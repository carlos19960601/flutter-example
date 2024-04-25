import 'package:flutter/widgets.dart';
import 'package:parallax_effect/core/app_color.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 24,
        ),
        MyTab(text: 'Nearby', isSelected: false),
        MyTab(text: 'Recent', isSelected: true),
        MyTab(text: 'Notice', isSelected: false),
      ],
    );
  }
}

class MyTab extends StatelessWidget {
  const MyTab({
    super.key,
    required this.isSelected,
    required this.text,
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: isSelected ? 16 : 14,
              color: isSelected ? AppColor.black : AppColor.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Container(
            height: 6,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? const Color(0xFFFF5A1D) : AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
