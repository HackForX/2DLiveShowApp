import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thai_stock_live/pages/app_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AppPage());
}
