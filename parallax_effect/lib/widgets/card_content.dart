import 'package:flutter/material.dart';
import 'package:parallax_effect/core/app_color.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
    required this.name,
    required this.date,
  });

  final String name;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text(date, style: const TextStyle(color: AppColor.grey)),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF162A49),
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {},
                child: const Text("Reserve"),
              ),
              const Spacer(),
              const Text(
                "0.00 \$",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
