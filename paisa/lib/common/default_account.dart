import 'package:flutter/material.dart';
import 'package:paisa/model/account.dart';
import 'package:paisa/model/card_type.dart';

List<AccountModel> defaultAccounts() {
  return [
    AccountModel(
      name: 'User name',
      bankName: 'Cash',
      number: '',
      cardType: CardType.cash,
      amount: 0.0,
      color: Colors.primaries[0].value,
    ),
    AccountModel(
      name: 'User name',
      bankName: 'Bank',
      number: '',
      cardType: CardType.bank,
      amount: 0.0,
      color: Colors.primaries[1].value,
    ),
    AccountModel(
      name: 'User name',
      bankName: 'Wallet',
      number: '',
      cardType: CardType.wallet,
      amount: 0.0,
      color: Colors.primaries[2].value,
    ),
  ];
}
