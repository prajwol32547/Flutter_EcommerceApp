import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class Cart_controller extends GetxController {
  RxInt count = 0.obs;
  void increase() {
    count++;
  }

  void decrement() {
    if (count > 0) {
      count--;
    }
  }
}
