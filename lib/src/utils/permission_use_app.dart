import 'package:permission_handler/permission_handler.dart';

Future<bool> isGrantedRequestPermissionStorage() async {
  var status = await Permission.manageExternalStorage.request();

  var status1 = await Permission.storage.request();

  return status1.isGranted || status.isGranted;
}

Future<bool> isContactsPermissionGranted() async {
  var status = await Permission.contacts.request();
  return status.isGranted;
}

Future<bool> isGranted() async {
  bool isGrantedPermission = true;
  if (!await isGrantedRequestPermissionStorage()) {
    openAppSettings();
    isGrantedPermission = false;
  }

  return isGrantedPermission;
}
