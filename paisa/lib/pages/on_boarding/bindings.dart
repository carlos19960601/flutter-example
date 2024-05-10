import 'package:get/get.dart';
import 'package:paisa/pages/on_boarding/controller.dart';

class OnboardingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}
