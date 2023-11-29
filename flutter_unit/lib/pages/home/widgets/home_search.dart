import 'package:flutter/material.dart';
import 'package:flutter_unit/common/toly_icon.dart';
import 'package:flutter_unit/common/widgets/feedback_widget.dart';

class HomeSearch extends StatelessWidget implements PreferredSizeWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 15),
          FeedbackWidget(
            onPressed: () {},
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/icon_head.webp'),
            ),
          ),
          Expanded(
            child: Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Material(
                color: Colors.transparent,
                child: TextField(
                  maxLength: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF3F6F9),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          35 / 2,
                        ),
                      ),
                    ),
                    hintText: "搜索组件",
                    hintStyle: TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Icon(TolyIcon.icon_sound),
          const SizedBox(width: 15)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(35 + 8 * 2);
}
