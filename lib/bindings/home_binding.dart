import 'package:get/get.dart';
import 'package:thai_stock_live/controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(),fenix: true) ;
  }
}