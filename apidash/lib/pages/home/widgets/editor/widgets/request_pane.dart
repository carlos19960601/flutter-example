import 'package:apidash/common/widgets/request_widgets.dart';
import 'package:apidash/pages/home/widgets/collection/controller.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/request_pane/request_body.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/request_pane/request_headers.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/request_pane/request_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRequestPane extends StatefulWidget {
  const EditRequestPane({super.key});

  @override
  State<EditRequestPane> createState() => _EditRequestPaneState();
}

class _EditRequestPaneState extends State<EditRequestPane> {
  final CollectionController collectionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RequestPane(
        codePaneVisible: false,
        tabIndex:
            collectionController.activeRequestModel.value?.requestTabIndex ?? 0,
        onTapTabBar: (int index) {
          collectionController.updateRequestTabIndex(index);
        },
        children: const [
          EditRequestURLParams(),
          EditRequestHeaders(),
          EditRequestBody(),
        ],
      ),
    );
  }
}
