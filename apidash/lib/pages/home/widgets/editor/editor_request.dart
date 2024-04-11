import 'package:apidash/consts.dart';
import 'package:apidash/pages/home/widgets/collection/controller.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/details_card.dart';
import 'package:apidash/pages/home/widgets/editor/widgets/url_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestEditor extends StatelessWidget {
  const RequestEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RequestEditorTopBar(),
        const EditorPaneRequestURLCard(),
        kVSpacer10,
        const Expanded(child: EditorPaneRequestDetailsCard()),
      ],
    );
  }
}

class RequestEditorTopBar extends StatelessWidget {
  RequestEditorTopBar({super.key});

  final CollectionController collectionController =
      Get.find<CollectionController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 8, top: 4, bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => Text(
                collectionController.activeRequestModel.value?.name ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          SizedBox(
            width: 90,
            height: 24,
            child: FilledButton.tonalIcon(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
              ),
              onPressed: () {
                final controller = TextEditingController(
                    text: collectionController.activeRequestModel.value?.name ??
                        "");
                Get.dialog(
                  AlertDialog(
                    title: const Text('Rename Request'),
                    content: TextField(
                      autofocus: true,
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Enter new name",
                      ),
                    ),
                    actions: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Cancel"),
                      ),
                      FilledButton(
                        onPressed: () {
                          collectionController
                              .renameActiveRequest(controller.text);
                          Get.back();
                          controller.dispose();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                size: 12,
              ),
              label: Text(
                "Rename",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          )
        ],
      ),
    );
  }
}
