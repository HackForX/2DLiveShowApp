import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:thai_stock_live/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    FullScreenWindow.setFullScreen(true);
  }

  @override
  void dispose() {
    // Reset preferred orientations when the widget is disposed
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    FullScreenWindow.setFullScreen(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(
      builder: (controller) {
        DateTime now = DateTime.now();
        DateTime startTime1 = DateTime(now.year, now.month, now.day, 12, 00, 55);
        DateTime endTime1 = DateTime(now.year, now.month, now.day, 14, 00, 0);
        DateTime startTime2 = DateTime(now.year, now.month, now.day, 16, 29, 55);

        bool morning = now.isAfter(startTime1) &&
            now.isBefore(endTime1) &&
            controller.resultModel.result1200!.isNotEmpty;
        bool evening = now.isAfter(startTime2) &&
            controller.resultModel.result430!.isNotEmpty;
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  height: 80,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Marquee(
                    text: controller.localtopBaner.value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                        fontSize: 20),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  )),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "2D Live Result",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          morning == true || evening == true
                              ? Lottie.asset('assets/icons/correct.json',
                                  height: 35)
                              : Lottie.asset('assets/icons/loading.json',
                                  height: 40),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/icons/kpay.png',
                                height: 45,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/icons/wave.png',
                                height: 40,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/icons/aya.png',
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "Date: ${DateFormat('dd/M/yyyy').format(DateTime.now())}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 5.sp),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              DateFormat('h:mm:ss a').format(DateTime.now()),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "Set",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: morning == true || evening == true
                          ? Text(
                              controller.resultLiveSet.value,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              // Add ellipsis if it overflows
                            )
                          : AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                FadeAnimatedText(
                                  controller.number.liveSet.toString(),
                                  duration: const Duration(milliseconds: 1000),
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                  const SizedBox(
                    width: 30,
                  ),
                  const Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        "၁၀၀%စိတ်ချရတယ်",
                        style: TextStyle(
                            color: Color.fromARGB(255, 34, 18, 255),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Myanmar'
                            // fontSize: 30,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "Val",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: morning == true || evening == true
                          ? Text(
                              controller.resultLiveVal.value,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              // Add ellipsis if it overflows
                            )
                          : AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                FadeAnimatedText(
                                  controller.number.liveVal.toString(),
                                  duration: const Duration(milliseconds: 1000),
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                  const SizedBox(
                    width: 30,
                  ),
                  const Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Center(
                        child: Text(
                          "အတုအပ သတိပြုရန်",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 167, 6),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Myanmar',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Result:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.bold)),
                                morning == true || evening == true
                                    ? SizedBox(
                                        height: 150.h,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            controller.resultLiveNumber.value,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.green,
                                              shadows: const [
                                                BoxShadow(
                                                    color: Colors.black87,
                                                    offset: Offset(2, 3),
                                                    // spreadRadius: 1,
                                                    blurRadius: 1)
                                              ],
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 150.h,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: AnimatedTextKit(
                                            repeatForever: true,
                                            animatedTexts: [
                                              FadeAnimatedText(
                                                controller
                                                    .resultLiveNumber.value,
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                textStyle: TextStyle(
                                                  shadows: const [
                                                    BoxShadow(
                                                        color: Colors.black87,
                                                        offset: Offset(2, 3),
                                                        // spreadRadius: 1,
                                                        blurRadius: 1)
                                                  ],
                                                  color: Colors.green,
                                                  fontSize: 50.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ]),
                          Text(
                            "Present by ${controller.localappName.value}",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 239, 187, 0),
                                fontSize: 7.sp,
                                shadows: const [
                                  BoxShadow(
                                      color: Colors.greenAccent,
                                      offset: Offset(1, 2),
                                      // spreadRadius: 1,
                                      blurRadius: 1)
                                ],
                                fontFamily:
                                    GoogleFonts.notoSerifMyanmar().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Column(children: [
                        Visibility(
                          visible:
                              controller.number.isCloseDay == 1 ? false : true,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  formatCurrentDate(),
                                  style: TextStyle(fontSize: 8.sp),
                                ),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${controller.resultModel.result1200.toString()}(AM)",
                                  style: TextStyle(
                                      fontSize: 8.sp, color: Colors.redAccent),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${controller.resultModel.result430.toString()}(PM)",
                                  style: TextStyle(
                                      fontSize: 8.sp, color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...controller.historyNumbers
                            .take(controller.number.isCloseDay == 1 ? 5 : 4)
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   formatDate(e.date),
                                    //   style: TextStyle(fontSize: 8.sp),
                                    // ),
                                    // Text(
                                    //   "${e.result_1200}(AM)",
                                    //   style: TextStyle(
                                    //       fontSize: 8.sp,
                                    //       color: Colors.redAccent),
                                    // ),
                                    // Text(
                                    //   "${e.result_430}(PM)",
                                    //   style: TextStyle(
                                    //       fontSize: 8.sp,
                                    //       color: Colors.redAccent),
                                    // )
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        formatDate(e.date),
                                        style: TextStyle(fontSize: 8.sp),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${e.result_1200}(AM)",
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${e.result_430}(PM)",
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        const Spacer(),
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.file(
                      File(controller.localmyImagePath),
                      fit: BoxFit.cover,
                    )))
          ],
        );
      },
    ));
  }

  String formatDate(String dateString) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('dd-MM-yyyy-EEEE');
    final date = inputFormat.parse(dateString);
    return outputFormat.format(date);
  }

  String formatCurrentDate() {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('dd-MM-yyyy-EEEE');

    return outputFormat.format(DateTime.now());
  }
}
