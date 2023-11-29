import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter UI Kit"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 18,
            runSpacing: 18,
            children: [
              PageButton(
                page: 1,
                onPressed: () {
                  Get.toNamed("/pg1");
                },
              ),
              PageButton(
                page: 2,
                onPressed: () {
                  Get.toNamed("/pg2");
                },
              ),
              PageButton(
                page: 3,
                onPressed: () {
                  Get.toNamed("/pg3");
                },
              ),
              PageButton(
                page: 4,
                onPressed: () {
                  Get.toNamed("/pg4");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    super.key,
    required this.onPressed,
    required this.page,
  });

  final Function onPressed;
  final int page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        color: const Color(0xFFC4C4C4),
        height: 56,
        width: 56,
        child: Center(
          child: Text(
            "$page",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
