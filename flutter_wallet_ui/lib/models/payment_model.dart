import 'package:flutter/material.dart';

class PaymentModel {
  final IconData _icon;
  String _name, _date, _hour;
  final Color _color;
  final double _amount;
  final int _paymentType;

  PaymentModel(this._icon, this._color, this._name, this._date, this._hour,
      this._amount, this._paymentType);

  String get name => _name;

  String get date => _date;

  String get hour => _hour;

  double get amount => _amount;

  int get type => _paymentType;

  IconData get icon => _icon;

  Color get color => _color;
}

List<PaymentModel> paymentCards = [
  PaymentModel(Icons.receipt, const Color(0xFFffd60f), "Florenti Restaurant",
      "07-23", "20.04", 251.00, -1),
  PaymentModel(Icons.monetization_on, const Color(0xFFff415f),
      "Transfer To Anna", "07-23", "14.01", 64.00, -1),
  PaymentModel(Icons.location_city, const Color(0xFF50f3e2), "Loan To Sanchez",
      "07-23", "10.04", 1151.00, -1),
  PaymentModel(Icons.train, Colors.green, "Train ticket to Turkey", "07-23",
      "09.04", 37.00, -1),
];
