import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thai_stock_live/controllers/home_controller.dart';

class LoginPage extends GetView<HomeController> {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller.getUserName();
    // controller.getPass();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0,
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  TextFormField(
                    // initialValue: controller.localUserName,
                    controller:
                        TextEditingController(text: controller.localUserName),
                    onChanged: (value) {
                      print("Username $value");
                      controller.saveUserName(value);
                    },
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller:
                        TextEditingController(text: controller.localPassword),
                    onChanged: (value) {
                      print("Password $value");
                      controller.savePassword(value);
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password'
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Obx(
                  //   () => Row(
                  //     children: [
                  //       Checkbox(
                  //         value: controller.localRembember.value,
                  //         onChanged: (value) {
                  //           controller.setRemember(!controller.localRembember.value);
                  //         },
                  //       ),
                  //       const Text('Remember Username'),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () async {
                        await controller.getUserName();
                        await controller.getPass();

                        await controller.login(controller.localUserName!,
                            controller.localPassword!);

                        // Add your login logic here
                        // String username = usernameController.text;
                        // String password = passwordController.text;

                        // // Validate username and password
                        // if (username == 'your_username' &&
                        //     password == 'your_password') {
                        //   // Navigate to the next screen or perform the desired action
                        //   print('Login successful');
                        // } else {
                        //   // Show an error message or handle authentication failure
                        //   print('Login failed');
                        // }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
