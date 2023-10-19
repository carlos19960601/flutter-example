import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/model/card_type.dart';

part 'account.g.dart';

@HiveType(typeId: 2)
class AccountModel {
  @HiveField(0)
  double? amount;

  @HiveField(1)
  String? bankName;

  @HiveField(2, defaultValue: CardType.bank)
  CardType? cardType;

  @HiveField(3, defaultValue: 0xFFFFC107)
  int? color;

  @HiveField(4, defaultValue: false)
  bool? isAccountExcluded;

  @HiveField(5)
  String? name;

  @HiveField(6)
  String? number;

  AccountModel({
    required this.name,
    required this.bankName,
    required this.number,
    required this.cardType,
    required this.amount,
    required this.color,
    this.isAccountExcluded = false,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        name: json["name"],
        bankName: json["bankName"],
        number: json["number"],
        cardType: (json["cardType"] as String).type,
        amount: json["amount"],
        color: json["color"],
        isAccountExcluded: json["isAccountExcluded"],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'bankName': bankName,
        'number': number,
        'cardType': cardType?.name,
        'amount': amount,
        'color': color,
        'isAccountExcluded': isAccountExcluded,
      };

  AccountModel copyWith({
    String? name,
    int? icon,
    String? bankName,
    String? number,
    CardType? cardType,
    int? superId,
    double? amount,
    int? color,
    bool? isAccountExcluded,
  }) {
    return AccountModel(
      name: name ?? this.name,
      bankName: bankName ?? this.bankName,
      number: number ?? this.number,
      cardType: cardType ?? this.cardType,
      amount: amount ?? this.amount,
      color: color ?? this.color,
      isAccountExcluded: isAccountExcluded ?? this.isAccountExcluded,
    );
  }
}
