import 'package:get/get.dart';

/// Selected bottom-nav tab index for [MainShellView].
class MainShellController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTab(int index) => selectedIndex.value = index;
}
