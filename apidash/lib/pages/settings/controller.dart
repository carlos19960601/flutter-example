import 'package:apidash/models/codegen_language.dart';
import 'package:apidash/utils/storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  final Box settings = GStorage.settings;

  RxBool isDark = false.obs;
  RxBool alwaysShowCollectionPaneScrollbar = true.obs;
  RxString defaultUriScheme = "https".obs;
  RxBool saveResponses = false.obs;
  Rx<CodegenLanguage> defaultCodeGenLang = CodegenLanguage.curl.obs;
  RxBool promptBeforeClosing = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDark.value = settings.get(SettingBoxKey.isDark, defaultValue: false);
    alwaysShowCollectionPaneScrollbar.value = settings.get(
        SettingBoxKey.alwaysShowCollectionPaneScrollbar,
        defaultValue: true);
    defaultUriScheme.value =
        settings.get(SettingBoxKey.defaultUriScheme, defaultValue: "https");
    saveResponses.value =
        settings.get(SettingBoxKey.saveResponses, defaultValue: true);
    defaultCodeGenLang.value = settings.get(SettingBoxKey.defaultCodeGenLang,
        defaultValue: CodegenLanguage.curl);
    promptBeforeClosing.value =
        settings.get(SettingBoxKey.promptBeforeClosing, defaultValue: false);
  }

  toggleIsDark(bool value) {
    isDark.value = value;
    settings.put(SettingBoxKey.isDark, value);
  }

  toggleAlwaysShowCollectionPaneScrollbar(bool value) {
    alwaysShowCollectionPaneScrollbar.value = value;
    settings.put(SettingBoxKey.alwaysShowCollectionPaneScrollbar, value);
  }

  setDefaultUriSchema(String? value) {
    defaultUriScheme.value = value ?? "https";
    settings.put(SettingBoxKey.defaultUriScheme, value ?? "https");
  }

  toggleSaveResponses(bool? value) {
    saveResponses.value = value ?? false;
    settings.put(SettingBoxKey.saveResponses, value ?? false);
  }

  setDefaultCodeGenLang(CodegenLanguage? value) {
    defaultCodeGenLang.value = value ?? CodegenLanguage.curl;
    settings.put(
        SettingBoxKey.defaultCodeGenLang, value ?? CodegenLanguage.curl);
  }

  togglePromptBeforeClosing(bool? value) {
    promptBeforeClosing.value = value ?? false;
    settings.put(SettingBoxKey.promptBeforeClosing, value ?? false);
  }
}
