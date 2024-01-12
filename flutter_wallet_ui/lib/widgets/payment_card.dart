import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui/models/payment_model.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key, required this.payment});

  final PaymentModel payment;

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text(
        "${widget.payment.type > 0 ? "+" : "-"} \$ ${widget.payment.amount}",
        style: const TextStyle(
            inherit: true, fontWeight: FontWeight.w700, fontSize: 16.0),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          elevation: 10,
          shape: const CircleBorder(),
          shadowColor: widget.payment.color.withOpacity(0.4),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: widget.payment.color,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Icon(
                widget.payment.icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            widget.payment.name,
            style: const TextStyle(
                inherit: true, fontWeight: FontWeight.w700, fontSize: 16.0),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            Text(widget.payment.date,
                style: const TextStyle(
                    inherit: true, fontSize: 12.0, color: Colors.black45)),
            const SizedBox(
              width: 20,
            ),
            Text(widget.payment.hour,
                style: const TextStyle(
                    inherit: true, fontSize: 12.0, color: Colors.black45)),
          ],
        ),
      ),
    );
  }
}
