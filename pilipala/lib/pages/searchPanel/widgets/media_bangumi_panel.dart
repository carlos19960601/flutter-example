import 'package:flutter/material.dart';
import 'package:pilipala/common/constants.dart';

Widget searchMbangumiPanel(BuildContext context, ctr, list) {
  return ListView.builder(itemBuilder: (context, index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            StyleString.safeSpace, 7, StyleString.safeSpace, 7),
        child: Row(
          children: [],
        ),
      ),
    );
  });
}
