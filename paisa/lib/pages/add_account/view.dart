import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/localization/localization_keys.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({
    super.key,
    this.accountId,
  });

  final String? accountId;

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  late final bool isAccountAddOrUpdate = widget.accountId == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAccountAddOrUpdate
              ? LocalizationKeys.addAccount.tr
              : LocalizationKeys.updateAccount.tr,
        ),
        titleTextStyle:
            context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            onPressed: _showInfo,
            icon: const Icon(Icons.info_rounded),
          )
        ],
      ),
    );
  }

  void _showInfo() {}
}
