import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/dynamics/controller.dart';
import 'package:pilipala/pages/dynamics/widgets/author_panel.dart';
import 'package:pilipala/pages/dynamics/widgets/content_panel.dart';

class DynamicPanel extends StatelessWidget {
  final dynamic item;
  final String? source;
  DynamicPanel({super.key, this.item, this.source});

  final DynamicsController _dynamicsController = Get.put(DynamicsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: source == 'detail'
          ? const EdgeInsets.only(bottom: 12)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 8,
            color: Theme.of(context).dividerColor.withOpacity(0.05),
          ),
        ),
      ),
      child: Material(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: InkWell(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: AuthorPanel(item: item),
              ),
              if (item!.modules!.moduleDynamic!.desc != null ||
                  item!.modules!.moduleDynamic!.major != null)
                Content(item: item, source: source),
            ],
          ),
        ),
      ),
    );
  }
}
