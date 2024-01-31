class PrivilegeModel {
  int id;
  int fee;
  int payed;
  bool preSell;
  int? playMaxbr;
  int? maxbr;
  FreeTrialPrivilege? freeTrialPrivilege;

  PrivilegeModel(
    this.id,
    this.fee,
    this.payed,
    this.preSell,
    this.playMaxbr,
    this.maxbr,
    this.freeTrialPrivilege,
  );

  factory PrivilegeModel.fromJson(Map<String, dynamic> json) => PrivilegeModel(
        json['id'] as int,
        json['fee'] as int,
        json['payed'] as int,
        json['preSell'] as bool,
        json['playMaxbr'] as int?,
        json['maxbr'] as int?,
        json['freeTrialPrivilege'] == null
            ? null
            : FreeTrialPrivilege.fromJson(json['freeTrialPrivilege']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fee': fee,
        'payed': payed,
        'preSell': preSell,
        'playMaxbr': playMaxbr,
        'maxbr': maxbr,
        'freeTrialPrivilege': freeTrialPrivilege?.toJson(),
      };

  int? getMaxPlayBr() {
    return playMaxbr ?? maxbr;
  }
}

class FreeTrialPrivilege {
  bool resConsumable;
  bool userConsumable;

  FreeTrialPrivilege(
    this.resConsumable,
    this.userConsumable,
  );

  factory FreeTrialPrivilege.fromJson(Map<String, dynamic> json) =>
      FreeTrialPrivilege(
        json['resConsumable'] as bool,
        json['userConsumable'] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resConsumable': resConsumable,
        'userConsumable': userConsumable,
      };
}
