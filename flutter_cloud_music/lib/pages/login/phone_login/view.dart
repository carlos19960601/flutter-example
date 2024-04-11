import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/controller.dart';
import 'package:get/get.dart';

class PhoneLoginPage extends GetView<PhoneLoginController> {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "手机号登陆",
          style: headline1Style().copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
