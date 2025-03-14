import 'package:event_project_01/views/loader_Screen.dart';
import 'package:get/get.dart';

class loaderControler extends GetxController{
  var isLoading = false.obs;

  void startLoading() {
    isLoading.value = true;
    Get.dialog(
      const loaderScreen(),
      barrierDismissible: false, // Prevent dismissing manually
    );
  }

  void stopLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back(); // Close loading dialog
    }
    isLoading.value = false;
  }

}