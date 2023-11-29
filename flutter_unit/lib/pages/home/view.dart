import 'package:flutter/material.dart';
import 'package:flutter_unit/common/widgets/sliver_header/sliver_snap_header.dart';
import 'package:flutter_unit/pages/home/widgets/home_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      const SliverSnapHeader(
        child: HomeSearch(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    return Scaffold(
      body: Column(
        children: [
          AnnotatedRegion(
            value: appBarTheme.systemOverlayStyle!,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).padding.top,
            ),
          ),
          Expanded(
              child: NestedScrollView(
                  headerSliverBuilder: _buildHeader, body: const Placeholder()))
        ],
      ),
    );
  }
}
