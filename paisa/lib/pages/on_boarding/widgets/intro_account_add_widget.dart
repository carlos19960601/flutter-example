import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/localization/localization_keys.dart';
import 'package:paisa/model/account.dart';
import 'package:paisa/model/card_type.dart';
import 'package:paisa/pages/on_boarding/controller.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_image_picker_widget.dart';
import 'package:paisa/routes/app_routes.dart';
import 'package:paisa/services/account_service.dart';
import 'package:paisa/widgets/paisa_card.dart';

class IntroAccountAddWidget extends StatefulWidget {
  const IntroAccountAddWidget({super.key});

  @override
  State<IntroAccountAddWidget> createState() => _IntroAccountAddWidgetState();
}

class _IntroAccountAddWidgetState extends State<IntroAccountAddWidget> {
  final OnboardingController controller = Get.find<OnboardingController>();
  final AccountService accountService = Get.find<AccountService>();
  final Box setting = AppStorage.setting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          IntroTopWidget(
            title: LocalizationKeys.addAccount.tr,
            icon: Icons.credit_card_outlined,
          ),
          Obx(
            () => PaisaFilledCard(
              child: ListView.separated(
                shrinkWrap: true,
                // 确保这个ListView不会单独滚动
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final AccountModel model =
                      accountService.accountList.elementAt(index);
                  return AccountItemWidget(
                    model: model,
                    onPress: () => accountService.delete(index),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: accountService.accountList.length,
              ),
            ),
          ),
          ListTile(
            title: Text(
              LocalizationKeys.recommendedAccounts.tr,
              style: context.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16,
            ),
            child: Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ...accountService.defaultModels
                      .sorted((a, b) => a.name!.compareTo(b.name!))
                      .map(
                        (e) => FilterChip(
                          label: Text(e.bankName ?? ""),
                          labelStyle: context.titleMedium,
                          padding: const EdgeInsets.all(12),
                          onSelected: (value) {
                            accountService.add(e);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                            side: BorderSide(
                              width: 1,
                              color: context.primary,
                            ),
                          ),
                          avatar: Icon(
                            e.cardType!.icon,
                            color: context.primary,
                          ),
                        ),
                      )
                      .toList(),
                  FilterChip(
                    selected: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide(
                        width: 1,
                        color: context.primary,
                      ),
                    ),
                    label: Text(LocalizationKeys.addAccount.tr),
                    labelStyle: context.titleMedium,
                    onSelected: (value) {
                      Get.toNamed(AppRoutes.accountSelector);
                    },
                    showCheckmark: false,
                    padding: const EdgeInsets.all(12),
                    avatar: Icon(
                      Icons.add_rounded,
                      color: context.primary,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AccountItemWidget extends StatelessWidget {
  const AccountItemWidget({
    super.key,
    required this.model,
    required this.onPress,
  });

  final AccountModel model;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Icon(
        model.cardType!.icon,
        color: Color(model.color ?? Colors.brown.shade200.value),
      ),
      title: Text(model.bankName ?? ""),
      subtitle: Text(model.name ?? ""),
      trailing: Icon(MdiIcons.delete),
    );
  }
}
