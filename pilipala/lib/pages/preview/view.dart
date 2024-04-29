import 'package:flutter/material.dart';

typedef DoubleClickAnimationListener = void Function();

class ImagePreview extends StatefulWidget {
  const ImagePreview({
    super.key,
    this.initialPage,
    this.imgList,
  });

  final int? initialPage;
  final List<String>? imgList;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
