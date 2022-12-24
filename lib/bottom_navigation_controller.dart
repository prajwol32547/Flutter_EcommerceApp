import 'package:get/state_manager.dart';

class bottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
