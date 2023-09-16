import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/webview/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final WebviewController _webViewController = Get.put(WebviewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(_webViewController.pageTitle,
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          TextButton(
            onPressed: () {
              _webViewController.controller.reload();
            },
            child: const Text("刷新"),
          )
        ],
      ),
      body: Column(
        children: [
          if (_webViewController.type.value == "login")
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
              child: const Text('登录成功未自动跳转?  请点击右上角「刷新登录状态」'),
            ),
          Expanded(
            child: WebViewWidget(
              controller: _webViewController.controller,
            ),
          ),
        ],
      ),
    );
  }
}
