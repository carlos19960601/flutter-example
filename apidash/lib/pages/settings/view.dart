import 'package:apidash/consts.dart';
import 'package:apidash/models/codegen_language.dart';
import 'package:apidash/pages/settings/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: kPh20t40,
          child: Text(
            "Settings",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const Padding(
          padding: kPh20,
          child: Divider(
            height: 1,
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: kPh20,
            children: [
              Obx(
                () => SwitchListTile(
                  hoverColor: kColorTransparent,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Switch Theme Mode'),
                  subtitle: Text(
                      'Current selection: ${controller.isDark.value ? "Dark Mode" : "Light mode"}'),
                  value: controller.isDark.value,
                  onChanged: controller.toggleIsDark,
                ),
              ),
              Obx(
                () => SwitchListTile(
                  hoverColor: kColorTransparent,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Collection Pane Scrollbar Visiblity'),
                  subtitle: Text(
                      'Current selection: ${controller.alwaysShowCollectionPaneScrollbar.value ? "Always show" : "Show only when scrolling"}'),
                  value: controller.alwaysShowCollectionPaneScrollbar.value,
                  onChanged: controller.toggleAlwaysShowCollectionPaneScrollbar,
                ),
              ),
              Obx(
                () => ListTile(
                  contentPadding: EdgeInsets.zero,
                  hoverColor: kColorTransparent,
                  title: const Text('Default URI Scheme'),
                  subtitle: Text(
                      '$kDefaultUri → ${controller.defaultUriScheme.value}://$kDefaultUri'),
                  trailing: DropdownMenu(
                    initialSelection: controller.defaultUriScheme.value,
                    dropdownMenuEntries: kSupportedUriSchemes
                        .map<DropdownMenuEntry<String>>((value) {
                      return DropdownMenuEntry(value: value, label: value);
                    }).toList(),
                    onSelected: controller.setDefaultUriSchema,
                  ),
                ),
              ),
              Obx(
                () => ListTile(
                  contentPadding: EdgeInsets.zero,
                  hoverColor: kColorTransparent,
                  title: const Text('Default Code Generator'),
                  trailing: DropdownMenu(
                    initialSelection: controller.defaultCodeGenLang.value,
                    dropdownMenuEntries: CodegenLanguage.values
                        .map<DropdownMenuEntry<CodegenLanguage>>(
                      (value) {
                        return DropdownMenuEntry<CodegenLanguage>(
                          value: value,
                          label: value.label,
                        );
                      },
                    ).toList(),
                    onSelected: controller.setDefaultCodeGenLang,
                  ),
                ),
              ),
              Obx(
                () => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  hoverColor: kColorTransparent,
                  title: const Text("Save Responses"),
                  subtitle: const Text(
                      "Save disk space by not storing API responses"),
                  value: controller.saveResponses.value,
                  onChanged: controller.toggleSaveResponses,
                ),
              ),
              Obx(
                () => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Show Save Alert on App Close"),
                  subtitle: const Text(
                      "Show a confirmation dialog to save workspace when the user closes the app"),
                  value: controller.promptBeforeClosing.value,
                  onChanged: controller.togglePromptBeforeClosing,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                hoverColor: kColorTransparent,
                title: const Text('Export Data'),
                subtitle: const Text(
                    'Export your collection to HAR (HTTP Archive format).\nVersion control this file or import in other API clients.'),
                trailing: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_outward_rounded),
                  label: const Text("Export"),
                ),
              ),
              Obx(
                () => ListTile(
                  contentPadding: EdgeInsets.zero,
                  hoverColor: kColorTransparent,
                  title: const Text('Clear Data'),
                  subtitle:
                      const Text('Delete all requests data from the disk'),
                  trailing: FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(
                      backgroundColor: controller.isDark.value
                          ? kColorDarkDanger
                          : kColorLightDanger,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {},
                    label: const Text("Clear"),
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
