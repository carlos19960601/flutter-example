import 'package:apidash/common/widgets/split_views.dart';
import 'package:apidash/pages/home/widgets/collection/view.dart';
import 'package:apidash/pages/home/widgets/editor/editor_panel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: DashboardSplitView(
            sidebarWidget: CollectionPane(),
            mainWidget: RequestEditorPane(),
          ),
        ),
      ],
    );
  }
}
