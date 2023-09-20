import 'package:flutter/material.dart';

class HttpError extends StatelessWidget {
  const HttpError(
      {required this.errMsg, required this.fn, this.btnText, super.key});

  final String? errMsg;
  final Function()? fn;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errMsg ?? "请求错误"),
    );
  }
}
