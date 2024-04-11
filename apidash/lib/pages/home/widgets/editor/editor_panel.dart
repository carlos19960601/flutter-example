import 'package:apidash/consts.dart';
import 'package:apidash/pages/home/widgets/collection/controller.dart';
import 'package:apidash/pages/home/widgets/editor/editor_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestEditorPane extends StatefulWidget {
  const RequestEditorPane({super.key});

  @override
  State<RequestEditorPane> createState() => _RequestEditorPaneState();
}

class _RequestEditorPaneState extends State<RequestEditorPane> {
  final CollectionController _collectionController =
      Get.find<CollectionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _collectionController.activeId.isEmpty
          ? RequestEditorDefault()
          : const Padding(
              padding: kPt24o8,
              child: RequestEditor(),
            ),
    );
  }
}

class RequestEditorDefault extends StatelessWidget {
  RequestEditorDefault({super.key});

  final CollectionController _collectionController =
      Get.find<CollectionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Click ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              WidgetSpan(
                child: ElevatedButton(
                  onPressed: () {
                    _collectionController.add();
                  },
                  child: const Text(
                    kLabelPlusNew,
                    style: kTextStyleButton,
                  ),
                ),
              ),
              TextSpan(
                text: "  to start drafting a new API request.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
