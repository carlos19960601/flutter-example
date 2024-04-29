import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pilipala/models/dynamics/result.dart';
import 'package:pilipala/pages/dynamics/controller.dart';

class ActionPanel extends StatefulWidget {
  const ActionPanel({super.key, this.item});

  final item;

  @override
  State<ActionPanel> createState() => _ActionPanelState();
}

class _ActionPanelState extends State<ActionPanel> {
  final DynamicsController _dynamicsController = Get.put(DynamicsController());
  late ModuleStatModel stat;
  bool isProcessing = false;
  void Function()? handleState(Future Function() action) {
    return isProcessing
        ? null
        : () async {
            setState(() => isProcessing = true);
            await action();
            setState(() => isProcessing = false);
          };
  }

  @override
  void initState() {
    super.initState();
    stat = widget.item!.modules.moduleStat;
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.outline;
    var primary = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.shareFromSquare,
              size: 16,
            ),
            label: Text(stat.forward!.count ?? "转发"),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              foregroundColor: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () => _dynamicsController.pushDetail(widget.item, 1,
                action: "comment"),
            icon: const Icon(
              FontAwesomeIcons.comment,
              size: 16,
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              foregroundColor: Theme.of(context).colorScheme.outline,
            ),
            label: Text(stat.comment!.count ?? '评论'),
          ),
        ),
      ],
    );
  }
}
