import 'package:apidash/common/widgets/dropdowns.dart';
import 'package:apidash/consts.dart';
import 'package:apidash/pages/home/widgets/collection/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditorPaneRequestURLCard extends StatefulWidget {
  const EditorPaneRequestURLCard({super.key});

  @override
  State<EditorPaneRequestURLCard> createState() =>
      _EditorPaneRequestURLCardState();
}

class _EditorPaneRequestURLCardState extends State<EditorPaneRequestURLCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Row(
          children: [
            DropdownButtonHTTPMethod(),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonHTTPMethod extends StatefulWidget {
  const DropdownButtonHTTPMethod({super.key});

  @override
  State<DropdownButtonHTTPMethod> createState() =>
      _DropdownButtonHTTPMethodState();
}

class _DropdownButtonHTTPMethodState extends State<DropdownButtonHTTPMethod> {
  final CollectionController _collectionController =
      Get.find<CollectionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonHttpMethod(
        method: _collectionController.activeRequestModel.value?.method,
        onChanged: (HTTPVerb? value) {
          _collectionController.updateRequest(
            _collectionController.activeId.value,
            method: value,
          );
        },
      ),
    );
  }
}
