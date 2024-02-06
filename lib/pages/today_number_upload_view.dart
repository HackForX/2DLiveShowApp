import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:thai_stock_live/models/result_model.dart';

import '../controllers/home_controller.dart';
import 'set_value_upload_view.dart';

class TodayNumbersUploadView extends GetView<HomeController> {
  const TodayNumbersUploadView({super.key});

  // final List<String> times = [
  //   '11:00AM',
  //   '1:00PM',
  //   '3:00PM',
  //   '5:00PM',
  //   '7:00PM',
  //   '9:00PM',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0,
          title: Text(
            'Upload Result Numbers',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.fetchResultNumbers();
          },
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '12:00 AM',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 3,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.grey)),
                          title: Text(controller.resultModel.result1200 ?? ""),
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Get.to(() => SetValueUploadView(
                                time: '12:00 AM',
                                round: 1,
                              ));
                        },
                      ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '4:30 PM',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 3,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.grey)),
                          title: Text(controller.resultModel.result430 ?? ""),
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Get.to(() => SetValueUploadView(
                                time: '4:30 PM',
                                round: 2,
                              ));
                        },
                      ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(13)),
                    onPressed: () {
                      _showAlertDialog(context);
                      // Combine selectedDate and selectedTime into a single DateTime object
                    },
                    child: Text(
                      'Restart ',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  int getHour(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    return hour;
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Restart Game'),
          content: const Text('Are you sure want to restart?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                controller.restartGame(
                  ResultModel(),
                );
                Get.back();
                // Perform OK button action here
                // You can add your custom logic here.
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
