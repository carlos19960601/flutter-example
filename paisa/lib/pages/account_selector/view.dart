import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/common/default_account.dart';
import 'package:paisa/localization/translation_keys.dart' as translation;
import 'package:paisa/model/account.dart';
import 'package:paisa/utils/storage.dart';

class AccountSelectorPage extends StatefulWidget {
  const AccountSelectorPage({super.key});

  @override
  State<AccountSelectorPage> createState() => _AccountSelectorPageState();
}

class _AccountSelectorPageState extends State<AccountSelectorPage> {
  Box setting = GStorage.setting;
  Box accounts = GStorage.accounts;
  late List<AccountModel> defaultModels;

  Future<void> saveAndNavigate() async {}

  @override
  void initState() {
    super.initState();
    List<String> selected = accounts.values.map((e) {
      AccountModel model = e as AccountModel;
      return model.number ?? "";
    }).toList();
    defaultModels = defaultAccounts()
        .where((element) => !selected.contains(element.name))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation.accounts.tr),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        actions: [
          ElevatedButton(
            onPressed: saveAndNavigate,
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).primaryColor),
            child: Text(
              translation.done.tr,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              translation.addedAccounts.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
