import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class SetValueUploadView extends GetView<HomeController> {
  final String time;
  final int round;
  SetValueUploadView({super.key, required this.time, required this.round});

  final TextEditingController _setController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(time),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Number',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10),
                      )),
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(13)),
              onPressed: () {
                if (round == 1) {
                  controller.add1200AM(_numberController.text);
                }
                if (round == 2) {
                  controller.add430PM(_numberController.text);
                }

                // Combine selectedDate and selectedTime into a single DateTime object
                // DateTime selectedDateTime = DateTime(
                //   selectedDate.year,
                //   selectedDate.month,
                //   selectedDate.day,
                // );
                // String formattedDateString =
                //     DateFormat('MMMM d, y').format(selectedDateTime);

                // homeController.addLuckyNumberToFirestore(LiveNumberModel(
                //     time: selectedTime,
                //     set: _setNumberController.text,
                //     value: _valNumberController.text,
                //     number: _numberController.text,
                //     date: formattedDateString));
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
