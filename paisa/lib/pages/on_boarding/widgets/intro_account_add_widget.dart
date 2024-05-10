import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa/core/app_extensions.dart';
import 'package:paisa/localization/localization_keys.dart';
import 'package:paisa/model/account.dart';
import 'package:paisa/model/card_type.dart';
import 'package:paisa/pages/on_boarding/controller.dart';
import 'package:paisa/pages/on_boarding/widgets/intro_image_picker_widget.dart';
import 'package:paisa/widgets/paisa_card.dart';

class IntroAccountAddWidget extends StatefulWidget {
  const IntroAccountAddWidget({super.key});

  @override
  State<IntroAccountAddWidget> createState() => _IntroAccountAddWidgetState();
}

class _IntroAccountAddWidgetState extends State<IntroAccountAddWidget> {
  final OnboardingController controller = Get.find<OnboardingController>();

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
          PaisaFilledCard(
            child: ListView.separated(
              shrinkWrap: true,
              // 确保这个ListView不会单独滚动
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return null;
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: controller.accountList.length,
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
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...defaultAccounts
                    .sorted((a, b) => a.name!.compareTo(b.name!))
                    .map(
                      (e) => FilterChip(
                        label: Text(e.bankName ?? ""),
                        labelStyle: context.titleMedium,
                        padding: const EdgeInsets.all(12),
                        onSelected: (value) {},
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
                  onSelected: (value) {},
                  padding: const EdgeInsets.all(12),
                  avatar: Icon(
                    Icons.add_rounded,
                    color: context.primary,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
