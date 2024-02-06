import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thai_stock_live/models/result_model.dart';
import 'package:thai_stock_live/models/user_model.dart';
import 'package:thai_stock_live/pages/setting_page.dart';

import '../helpers/base_client.dart';
import '../models/history_model.dart';
import '../models/live_model.dart';

import '../helpers/api_call_status.dart';
import "../helpers/apis.dart";

class HomeController extends GetxController {
  Live number = Live(
      live: "33",
      liveSet: "??",
      liveVal: "??",
      set1200: "??",
      val1200: "??",
      set430: "??",
      val430: "??",
      modern200: "??",
      modern930: "??",
      internet200: "??",
      internet930: "??",
      result1200: "??",
      result430: "??");
  Rx<String> resultLiveNumber = "".obs;

  Rx<String> resultLiveSet = "".obs;
  Rx<String> resultLiveVal = "".obs;
  Rx<String> appName = "Add your appname".obs;
  Rx<String> topBaner = "Add your top banner text".obs;
  Rx<String> localappName = "Add your appname".obs;
  RxBool localRembember = false.obs;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Rx<String> localtopBaner = "Add your top banner text".obs;
  final Rx<String?> _localUserName = "".obs;
  final Rx<String?> _localPassword = "".obs;
  final Rx<String> _username = "".obs;
  final Rx<String> _password = "".obs;
  final RxBool _isRemeber = false.obs;
  bool get isRembember => _isRemeber.value;
  final Rx<ResultModel> _resultModel = ResultModel().obs;
  ResultModel get resultModel => _resultModel.value;
  final RxString _myImagePath = ''.obs;

  String get myImagePath => _myImagePath.value;

  final RxString _localmyImagePath = ''.obs;

  String get localmyImagePath => _localmyImagePath.value;
  String get username => _username.value;
  String get password => _password.value;

  final Rx<String> _newUsername = "".obs;
  final Rx<String> _newPassword = "".obs;
  final Rx<String> _updatePassword = "".obs;

  String get newUserName => _newUsername.value;
  String get newPassword => _newPassword.value;
  String? get localUserName => _localUserName.value;
  String? get localPassword => _localPassword.value;

  String get updatePassword => _updatePassword.value;

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  getData() async {
    apiCallStatus = ApiCallStatus.loading;
    update();

    await BaseClient.get(
      Constants.modernInternet, // url
      onSuccess: (response) {
        print(response.data);

        LiveModel liveModel = LiveModel.fromJson(response.data);

        number = liveModel.data!;
        // number.live = liveModel.live.result_1200;
        update();
      },
      onError: (error) {
        print(error.message);
        print(error.statusCode);
        print(error.toString());
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  changeNumber() async {
    DateTime currentTime = DateTime.now();
    int hours = currentTime.hour;
    int minutes = currentTime.minute;
    await getData();
    fetchResultNumbers();

    if (number.isCloseDay == 1) {
      resultLiveNumber.value = number.result430.toString();
      resultLiveSet.value = number.set430.toString();
      resultLiveVal.value = number.val430.toString();
    } else {
      if (_isMorning(DateTime.now()) && resultModel.result1200!.isNotEmpty) {
        resultLiveNumber.value = resultModel.result1200!;
        resultLiveSet.value = number.set1200.toString();
        resultLiveVal.value = number.val1200.toString();
      } else if (_isEvening(DateTime.now()) &&
          resultModel.result430!.isNotEmpty) {
        resultLiveNumber.value = resultModel.result430!;
        // resultLiveSet.value = number.set1200.toString();

        resultLiveSet.value = number.set430.toString();
        resultLiveVal.value = number.val430.toString();
      } else {
        resultLiveNumber.value = number.live.toString();
        resultLiveSet.value = number.liveSet.toString();
        resultLiveVal.value = number.liveVal.toString();
      }
    }
  }

  bool _isMorning(DateTime time) {
    int hours = time.hour;
    int minutes = time.minute;

    if (hours == 12 && minutes >= 1) {
      return true;
    } else if (hours > 12 && hours < 14) {
      return true;
    } else if (hours == 14 && minutes == 0) {
      return true;
    }

    return false;
  }

  bool _isEvening(DateTime time) {
    int currentHour = time.hour;
    int currentMinute = time.minute;

    // Check if it's between 16:30 (4:30 PM) and 23:59 (11:59 PM)
    if ((currentHour > 16 || (currentHour == 16 && currentMinute >= 30)) &&
        currentHour <= 23) {
      return true;
    }

    // Check if it's between 00:00 (midnight) and 09:00 (9:00 AM) of the next day
    if ((currentHour == 0 && currentMinute <= 0) ||
        (currentHour < 9 && currentHour >= 0)) {
      return true;
    }

    return false;
  }

  void showSnackBar(String content) {
    Get.snackbar("TEst", content);
  }

  setAppName(String data) {
    appName.value = data;
  }

  setTopBannerText(String data) {
    topBaner.value = data;
  }

  setRemember(bool isRemember) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("remember", isRembember);
    getRemember();
  }

  getRemember() async {
    final prefs = await SharedPreferences.getInstance();
    localRembember.value = prefs.getBool("remember") ?? false;
  }

  List<TwoDHistory> historyNumbers = [];
  final RxList<UserModel> _users = RxList.empty();
  List<UserModel> get users => _users.toList();

  getHistories() async {
    apiCallStatus = ApiCallStatus.loading;
    update();

    await BaseClient.get(
      Constants.twoDHistory, // url
      onSuccess: (response) {
        // print("History"+response.data);

        TwoDHistoryModel historyModel =
            TwoDHistoryModel.fromJson(response.data);

        historyNumbers = historyModel.data;

        apiCallStatus = ApiCallStatus.success;
        update();

        //  for (var element in response.data["data"]) {
        //   print(element);
        //    if(element["live"]!=false){

        //    }
        //  }
        // Logger().e(todayResultModel.twod);
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        print(error.message);
        print(error.response);

        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  Future<void> saveAppName(String appName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("app", appName);
  }

  Future<void> getAppName() async {
    final prefs = await SharedPreferences.getInstance();
    localappName.value = prefs.getString("app") ?? "Add your app name";
  }

  Future<void> saveUserName(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
  }

  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    _localUserName.value = prefs.getString("username") ?? "";
    print("Local ${_localUserName.value}");
  }

  Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("pass", password);
  }

  Future<void> getPass() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('pass'));
    _localPassword.value = prefs.getString("pass") ?? "";
    print("Global ${_localPassword.value}");
  }

  Future<void> saveTopBannerText(String appName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("topBanner", appName);
  }

  Future<void> getTopBannerText() async {
    final prefs = await SharedPreferences.getInstance();
    localtopBaner.value =
        prefs.getString("topBanner") ?? "Add your top banner ";
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePermanent = await saveFilePermanently(image.path);
      _localmyImagePath.value = imagePermanent.path;
      loadImage();
    } on PlatformException catch (e) {
      print("Error $e");
    }
  }

  Future<void> login(String username, String password) async {
    try {
      EasyLoading.show(status: "Loading..");
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      final List<UserModel> users = [];

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        if (document.exists) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          UserModel model = UserModel.fromJson(data);
          model.id = document.id;
          users.add(model);
        }
      }

      // Check if the entered username and password match any user in the list
      UserModel? currentUser = users.firstWhere(
        (user) => user.userName == username && user.password == password,
        // orElse: () => null,
      );

      if (currentUser != null) {
        print("Id ${currentUser.id}");
        Get.offAll(() => SettingPage(userModel: currentUser));
        EasyLoading.dismiss();
        // Successful login, navigate to the next screen
      } else {
        EasyLoading.showToast("Invalid username or password");

        // Username or password is incorrect, handle accordingly
      }
    } catch (e) {
      EasyLoading.showToast("Invalid username or password");
      EasyLoading.dismiss();

      print("Error $e");
      // Handle the error or return a default value as needed
      return;
    }
  }

  Future<void> fetchUsers() async {
    try {
      EasyLoading.show(status: "Loading..");
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      final List<UserModel> users = [];

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        if (document.exists) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          UserModel model = UserModel.fromJson(data);
          model.id = document.id;
          users.add(model);
        }
      }

      _users.value = users;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showToast("Invalid username or password");
      EasyLoading.dismiss();

      print("Error $e");
      // Handle the error or return a default value as needed
      return;
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("profilImage", image.path);

    return File(imagePath).copy(image.path);
  }

  void loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    _localmyImagePath.value = prefs.getString("profilImage") ?? '';
  }

  void setUserName(String username) {
    _username.value = username;
  }

  void setPassword(String password) {
    _password.value = password;
  }

  void setNewUserName(String username) {
    _newUsername.value = username;
  }

  void setNewPassword(String password) {
    _newPassword.value = password;
  }

  void setUpdatePassword(String password) {
    _updatePassword.value = password;
  }

  void addNewUser(String username, String password) async {
    try {
      EasyLoading.show(status: 'Loading');
      final collection = FirebaseFirestore.instance.collection('users');
      await collection.add(
          {'user_name': username, 'password': password, 'is_admin': false});
      EasyLoading.dismiss();
      EasyLoading.showToast("Success");
    } catch (e) {}
  }

  void deleteUser(String docId) async {
    try {
      EasyLoading.show(status: 'Loading');
      final collection = FirebaseFirestore.instance.collection('users');
      await collection.doc(docId).delete();
      EasyLoading.dismiss();
      EasyLoading.showToast("Success");
    } catch (e) {}
  }

  void updateNewPassword(String docId, String password) async {
    try {
      EasyLoading.show(status: 'Loading');
      final collection = FirebaseFirestore.instance.collection('users');
      await collection.doc(docId).update({'password': password});
      EasyLoading.dismiss();
      EasyLoading.showToast("Success");
    } catch (e) {}
  }

  Future<void> fetchResultNumbers() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('today') // Assuming the collection name is 'today'
          .doc('1') // Assuming the document ID is '1'
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        ResultModel model = ResultModel.fromJson(data);
        print("Model ${model.toJson()}");
        _resultModel.value = model;
      }
    } catch (e) {
      print("Error $e");
      // Handle the error or return a default value as needed
      return;
    }
  }

  // void getDeivceInfo() async {
  //   if (Platform.isAndroid) {
  //     final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     deviceIdentifier = androidInfo.id;
  //   }
  // }

  void add1200AM(String number) async {
    try {
      EasyLoading.show(status: 'Loading');
      final collection = FirebaseFirestore.instance.collection('today');
      await collection.doc('1').update({'result_1200': number});
      EasyLoading.dismiss();
      EasyLoading.showToast("Success");
    } catch (e) {}
  }

  void add430PM(String number) async {
    try {
      EasyLoading.show(status: 'Loading');
      final collection = FirebaseFirestore.instance.collection('today');
      await collection.doc('1').update({'result_430': number});
      EasyLoading.dismiss();
      EasyLoading.showToast("Success");
    } catch (e) {}
  }

  void restartGame(ResultModel todayModel) async {
    try {
      EasyLoading.show(status: 'Loading');
      final collection1 = FirebaseFirestore.instance.collection('today');

      await collection1.doc('1').update(todayModel.toJson());

      EasyLoading.dismiss();
      EasyLoading.showToast("Success");
    } catch (e) {}
  }

  @override
  void onInit() async {
    getUserName();
    getPass();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // getData();
      changeNumber();
    });
    getHistories();
    getAppName();
    getTopBannerText();

    loadImage();

    super.onInit();
  }
}
