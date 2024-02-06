import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thai_stock_live/bindings/home_binding.dart';

import 'package:thai_stock_live/pages/home_page.dart';
import 'package:thai_stock_live/pages/login_page.dart';
import 'package:thai_stock_live/pages/setting_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(_,child)=> GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.openSans(
            fontWeight: FontWeight.bold
          ).fontFamily,
        ),
        builder: EasyLoading.init(),
      initialBinding: HomeBinding(),
        home: LoginPage(),
      ),
    );
  }
}
