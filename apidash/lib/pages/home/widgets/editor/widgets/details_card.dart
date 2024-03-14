import 'package:apidash/common/widgets/cards.dart';
import 'package:apidash/common/widgets/split_views.dart';
import 'package:apidash/pages/home/widgets/collection/controller.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/code_pane.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/request_pane.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/response_pane.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditorPaneRequestDetailsCard extends StatefulWidget {
  const EditorPaneRequestDetailsCard({super.key});

  @override
  State<EditorPaneRequestDetailsCard> createState() =>
      _EditorPaneRequestDetailsCardState();
}

class _EditorPaneRequestDetailsCardState
    extends State<EditorPaneRequestDetailsCard> {
  final CollectionController _collectionController =
      Get.find<CollectionController>();
  @override
  Widget build(BuildContext context) {
    return RequestDetailsCard(
      child: EqualSplitView(
        leftWidget: const EditRequestPane(),
        rightWidget: Obx(
          () => _collectionController.codePaneVisible.value
              ? const CodePane()
              : const ResponsePane(),
        ),
      ),
    );
  }
}
