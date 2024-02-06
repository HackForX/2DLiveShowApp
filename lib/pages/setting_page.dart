import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thai_stock_live/controllers/home_controller.dart';
import 'package:thai_stock_live/models/user_model.dart';
import 'package:thai_stock_live/pages/home_page.dart';
import 'package:thai_stock_live/pages/today_number_upload_view.dart';
import 'package:thai_stock_live/pages/users_page.dart';

class SettingPage extends GetView<HomeController> {
  final UserModel userModel;
  SettingPage({super.key, required this.userModel});

  final TextEditingController _appNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text("Setting"),
          actions: [

             Visibility(
              visible: userModel.isAdmin,
              child: IconButton(
                  onPressed: () {
                    Get.to(() => TodayNumbersUploadView());
                  },
                  icon: const Icon(Icons.pin)),
            ),
            Visibility(
              visible: userModel.isAdmin,
              child: IconButton(
                  onPressed: () {
                    Get.to(() => UsersPage());
                  },
                  icon: const Icon(Icons.person)),
            ),
            IconButton(
                onPressed: () {
                  Get.to(() => const HomePage());
                },
                icon: const Icon(Icons.live_tv))
          ],
        ),
        body: Obx(
          () {
            return ListView(children: [
              ListTile(
                title: const Text("App Name"),
                subtitle: Text(controller.localappName.value),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _displayAppNameDialog(context);
                  },
                ),
              ),
              ListTile(
                title: const Text("Top Banner Text"),
                subtitle: Text(controller.localtopBaner.value),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _displayTopBannerDialog(context);
                  },
                ),
              ),
              ListTile(
                title: const Text("Bottom Banner Gif"),
                subtitle: Image.file(
                  File(controller.localmyImagePath),
                  height: 150,
                  fit: BoxFit.cover,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    controller.getImage(ImageSource.gallery);
                  },
                ),
              ),
              ListTile(
                title: const Text("Update Password"),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _displayPasswordDialog(context);
                  },
                ),
              )
            ]);
          },
        ));
  }

  Future<void> _displayAppNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Set AppName'),
            content: TextFormField(
              onChanged: (value) {
                controller.setAppName(value);
              },
              decoration: const InputDecoration(hintText: "App Name"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  Get.back();
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  controller.saveAppName(controller.appName.value);
                  controller.getAppName();
                  Get.back();
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayPasswordDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Password'),
            content: TextFormField(
              obscureText: true,
              onChanged: (value) {
                controller.setUpdatePassword(value);
              },
              decoration: const InputDecoration(hintText: "New Password"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  Get.back();
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  controller.updateNewPassword(
                      userModel.id, controller.updatePassword);
                  controller.getAppName();
                  Get.back();
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayTopBannerDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Set Top Banner Text'),
            content: TextFormField(
              onChanged: (value) {
                controller.setTopBannerText(value);
              },
              decoration: const InputDecoration(hintText: "Top Banner Text"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  Get.back();
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  controller.saveTopBannerText(controller.topBaner.value);
                  controller.getTopBannerText();
                  Get.back();
                },
              ),
            ],
          );
        });
  }
}
