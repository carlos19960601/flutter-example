import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'card_type.g.dart';

@HiveType(typeId: 12)
enum CardType {
  @HiveField(0)
  cash,

  @HiveField(1)
  bank,

  @HiveField(2)
  wallet,
}

extension CardTypeHelper on CardType {
  IconData get icon {
    switch (this) {
      case CardType.bank:
        return Icons.credit_card;
      case CardType.wallet:
        return Icons.wallet;
      case CardType.cash:
        return Icons.money;
    }
  }
}

extension CardTypeMap on String {
  CardType get type {
    switch (this) {
      case 'Cash':
        return CardType.cash;
      case 'Bank':
        return CardType.bank;
      case 'Wallet':
        return CardType.wallet;
    }
    return CardType.bank;
  }
}
