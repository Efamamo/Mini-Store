import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AlertDialogs {
  void showAlert({String? title, String? middleText}) {
    Get.defaultDialog(
      buttonColor: Color(0xff224b34),
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      title: title ?? 'Oops!',
      middleTextStyle: TextStyle(color: Colors.black),
      middleText: middleText ?? 'Unknown Error',
      textCancel: 'close',
    );
  }

  void showSuccess({String? title, String? middleText}) {
    Get.defaultDialog(
      buttonColor: Color(0xff224b34),
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      title: title ?? 'Success!',
      middleTextStyle: TextStyle(color: Colors.black),
      middleText: middleText ?? 'Unknown Error',
      textCancel: 'close',
    );
  }
}
