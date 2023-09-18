import 'package:flutter/material.dart';
import 'package:pilipala/common/constants.dart';

class RcmdPage extends StatefulWidget {
  const RcmdPage({super.key});

  @override
  State<RcmdPage> createState() => _RcmdPageState();
}

class _RcmdPageState extends State<RcmdPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          StyleString.imgRadius,
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(),
      ),
    );
  }
}
