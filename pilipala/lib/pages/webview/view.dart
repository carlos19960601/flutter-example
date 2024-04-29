import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/webview/controller.dart';
import 'package:url_launcher/url_launcher.dart';
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
        titleSpacing: 0,
        centerTitle: false,
        title: Text(_webViewController.pageTitle,
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          const SizedBox(width: 4),
          IconButton(
            onPressed: () {
              _webViewController.controller.reload();
            },
            icon: Icon(Icons.refresh_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
          IconButton(
            onPressed: () {
              launchUrl(Uri.parse(_webViewController.url));
            },
            icon: Icon(Icons.open_in_browser_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
          Obx(
            () => _webViewController.type.value == "login"
                ? TextButton(
                    onPressed: () {
                      _webViewController.confirmLogin(null);
                    },
                    child: const Text('刷新登录状态'),
                  )
                : const SizedBox(),
          ),
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
