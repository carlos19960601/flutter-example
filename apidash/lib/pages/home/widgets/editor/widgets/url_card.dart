import 'package:apidash/common/widgets/buttons.dart';
import 'package:apidash/common/widgets/dropdowns.dart';
import 'package:apidash/common/widgets/text_fields.dart';
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        borderRadius: kBorderRadius12,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Row(
          children: [
            DropdownButtonHTTPMethod(),
            kHSpacer20,
            Expanded(
              child: URLTextField(),
            ),
            kHSpacer20,
            SizedBox(
              height: 36,
              child: SendButton(),
            )
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

class SendButton extends StatefulWidget {
  const SendButton({super.key});

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  final CollectionController _collectionController =
      Get.find<CollectionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SendRequestButton(
        activeId: _collectionController.activeId.value,
        sentRequestId: _collectionController.sentRequestId.value,
        onTap: () {
          _collectionController.sendRequest();
        },
      ),
    );
  }
}

class URLTextField extends StatefulWidget {
  const URLTextField({super.key});

  @override
  State<URLTextField> createState() => _URLTextFieldState();
}

class _URLTextFieldState extends State<URLTextField> {
  final CollectionController _collectionController =
      Get.find<CollectionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => URLField(
        activeId: _collectionController.activeId.value,
        initialValue: _collectionController.activeRequestModel.value?.url,
        onChanged: (String value) {
          _collectionController
              .updateRequest(_collectionController.activeId.value, url: value);
        },
      ),
    );
  }
}
