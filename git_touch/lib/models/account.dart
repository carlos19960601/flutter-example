class Account {
  Account({
    required this.platform,
  });
  String platform;

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      platform: json["platform"],
    );
  }
}
