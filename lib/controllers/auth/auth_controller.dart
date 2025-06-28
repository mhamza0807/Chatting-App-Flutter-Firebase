import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  void startLoading() => isLoading.value = true;
  void stopLoading() => isLoading.value = false;
}

