import 'package:permission_handler/permission_handler.dart';

Future<bool> requestMicPermission() async {
  final status = await Permission.microphone.request();
  if (status != PermissionStatus.granted) {
    return false;
  }
  return true;
}

Future<bool> requestCameraAndMicPermissions() async {
  final camStatus = await Permission.camera.request();
  final micStatus = await Permission.microphone.request();

  return camStatus.isGranted || micStatus.isGranted;
}