import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:paisa/core/app_storage.dart';
import 'package:paisa/model/account.dart';

class AccountService extends GetxService {
  final Box setting = AppStorage.setting;
  final Box<AccountModel> accountBox = AppStorage.accounts;

  late RxList<AccountModel> accountList;
  final RxList<AccountModel> defaultModels = defaultAccounts.obs;

  @override
  onInit() {
    super.onInit();
    List<AccountModel> accounts = accountBox.values.toList();
    accountList = accounts.obs;
  }

  syncAccountList() {
    accountList.value = accountBox.values.toList();
  }

  List<AccountModel> accounts() => accountBox.values.toList();

  Future<int> add(AccountModel account) async {
    final AccountModel copiedAccount = account.copyWith(
      name: setting.get(
        SettingBoxKey.userNameKey,
        defaultValue: account.name,
      ),
    );
    final int id = await accountBox.add(copiedAccount);
    copiedAccount.superId = id;
    await copiedAccount.save();
    syncAccountList();

    defaultModels.remove(account);
    defaultModels.refresh();
    return id;
  }

  Future<void> clear() async {
    await accountBox.clear();
    syncAccountList();
  }

  Future<void> delete(int index) async {
    final AccountModel account = accountList.removeAt(index);
    accountList.refresh();
    await account.delete();
    syncAccountList();

    defaultModels.add(account);
    defaultModels.refresh();
  }

  Iterable<AccountModel> export() => accountBox.values;

  AccountModel? findById(int? accountId) {
    return accountBox.values
        .firstWhereOrNull((element) => element.superId == accountId);
  }

  Future<void> update(AccountModel accountModel) async {
    await accountBox.put(accountModel.superId!, accountModel);
    syncAccountList();
  }
}
