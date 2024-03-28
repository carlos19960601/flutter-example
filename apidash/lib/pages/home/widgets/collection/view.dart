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
    var sm = ScaffoldMessenger.of(context);
    return Padding(
      padding: kP24CollectionPane,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: kPr8CollectionPane,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _collectionController.savingData.value
                        ? null
                        : () async {
                            _collectionController.saveData();
                            sm.hideCurrentSnackBar();
                            sm.showSnackBar(
                              const SnackBar(
                                width: 300,
                                behavior: SnackBarBehavior.floating,
                                content: Text("Saved"),
                                showCloseIcon: true,
                              ),
                            );
                          };
                  },
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
                      _collectionController.add();
                    },
                    child: const Text(
                      kLabelPlusNew,
                      style: kTextStyleButton,
                    ))
              ],
            ),
          ),
          kVSpacer8,
          const Expanded(
            child: RequestList(),
          ),
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
          scrollController: _scrollController,
          buildDefaultDragHandles: false,
          itemBuilder: (context, index) {
            String id = _collectionController.ids[index];
            return ReorderableDragStartListener(
              index: index,
              key: ValueKey(id),
              child: Padding(
                key: ValueKey(id),
                padding: kP1,
                child: Obx(
                  () => RequestItem(
                    id: id,
                    requestModel: _collectionController.requestItems[id]!,
                  ),
                ),
              ),
            );
          },
          itemCount: _collectionController.ids.length,
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            if (oldIndex != newIndex) {
              _collectionController.reorder(oldIndex, newIndex);
            }
          },
        ),
      ),
    );
  }
}

class RequestItem extends StatefulWidget {
  const RequestItem({
    super.key,
    required this.id,
    required this.requestModel,
  });
  final String id;
  final RequestModel requestModel;

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  final CollectionController _collectionController =
      Get.find<CollectionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SidebarRequestCard(
        id: widget.id,
        method: widget.requestModel.method,
        name: widget.requestModel.name,
        url: widget.requestModel.url,
        editRequestId: _collectionController.editRequestId.value,
        activeRequestId: _collectionController.activeId.value,
        onTap: () {
          _collectionController.setActiveId(widget.id);
        },
        onDoubleTap: () {
          _collectionController.activeId.value = widget.id;
          _collectionController.editRequestId.value = widget.id;
        },
        onChangedNameEditor: (String value) {
          value = value.trim();
          RequestModel requestItem =
              _collectionController.requestItems[widget.id]!;
          requestItem.name = value;
        },
        onTapOutsideNameEditor: () {
          _collectionController.editRequestId.value = "";
        },
        focusNode: _collectionController.nameTextFieldFocusNode,
        onMenuSelected: (RequestItemMenuOption item) {
          if (item == RequestItemMenuOption.edit) {
            _collectionController.editRequestId.value = widget.id;
            _collectionController.nameTextFieldFocusNode.requestFocus();
          }
          if (item == RequestItemMenuOption.delete) {
            _collectionController.remove(widget.id);
          }
        },
      ),
    );
  }
}
