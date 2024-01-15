import 'package:git_touch/models/account.dart';

class PlatformType {
  static const github = 'github';
  static const gitlab = 'gitlab';
  static const bitbucket = 'bitbucket';
  static const gitea = 'gitea';
  static const gitee = 'gitee';
  static const gogs = 'gogs';
}

class AuthModel {
  static const _apiPrefix = 'https://api.github.com';

  final List<Account> _accounts = [];
  int? activeAccountIndex;

  Account? get activeAccount {
    if (activeAccountIndex == null || _accounts.isEmpty) return null;
    return _accounts[activeAccountIndex!];
  }
}
