import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies(){
    Get.put(AuthController(), permanent: true);
  }
}