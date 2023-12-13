import 'package:apidash/common/widgets/cards.dart';
import 'package:apidash/consts.dart';
import 'package:apidash/models/request_model.dart';
import 'package:apidash/pages/home/widgets/collection/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionPane extends StatefulWidget {
  const CollectionPane({super.key});

  @override
  State<CollectionPane> createState() => _CollectionPaneState();
}

class _CollectionPaneState extends State<CollectionPane> {
  final CollectionController _collectionController =
      Get.put(CollectionController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kP24CollectionPane,
      child: Column(
        children: [
          Padding(
            padding: kPr8CollectionPane,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.save,
                    size: 20,
                  ),
                  label: const Text(
                    kLabelSave,
                    style: kTextStyleButton,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      _collectionController.addCollection();
                    },
                    child: const Text(
                      kLabelPlusNew,
                      style: kTextStyleButton,
                    ))
              ],
            ),
          ),
          kVSpacer8,
          const Expanded(child: RequestList()),
        ],
      ),
    );
  }
}

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  final ScrollController _scrollController = ScrollController();
  final CollectionController _collectionController =
      Get.find<CollectionController>();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: Obx(
        () => ReorderableListView.builder(
          itemBuilder: (context, index) {
            String id = _collectionController.ids[index];
            return Padding(
              key: ValueKey(id),
              padding: kP1,
              child: RequestItem(
                id: id,
                requestModel: _collectionController.requestItems[id]!,
              ),
            );
          },
          itemCount: _collectionController.ids.length,
          onReorder: (oldIndex, newIndex) {},
        ),
      ),
    );
  }
}

class RequestItem extends StatelessWidget {
  RequestItem({
    super.key,
    required this.id,
    required this.requestModel,
  });
  final String id;
  final RequestModel requestModel;
  final CollectionController _collectionController =
      Get.find<CollectionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SidebarRequestCard(
          id: id,
          method: requestModel.method,
          name: requestModel.name,
          editRequestId: _collectionController.editRequestId.value,
          activeRequestId: _collectionController.activeId.value,
          onTap: () {
            _collectionController.activeId.value = id;
          },
          onDoubleTap: () {
            _collectionController.activeId.value = id;
            _collectionController.editRequestId.value = id;
          },
          onChangedNameEditor: (String value) {
            value = value.trim();
            RequestModel requestItem = _collectionController.requestItems[id]!;
            requestItem.name = value;
          },
          onTapOutsideNameEditor: () {
            _collectionController.editRequestId.value = "";
          },
        ));
  }
}
