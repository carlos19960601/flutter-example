import 'package:flutter/material.dart';
import 'package:v2ex/http/dio_web.dart';
import 'package:v2ex/models/tabs.dart';

class TabBarList extends StatefulWidget {
  const TabBarList({
    super.key,
    required this.tabItem,
    this.tabIndex = 0,
  });

  final TabModel tabItem;
  final int tabIndex;

  @override
  State<TabBarList> createState() => _TabBarListState();
}

class _TabBarListState extends State<TabBarList> {
  bool _isLoading = true;
  final int _currentPage = 0;
  bool _dioError = false;
  String _dioErrorMsg = '';

  @override
  void initState() {
    super.initState();
    getTopics();
  }

  Future getTopics() async {
    var id = widget.tabItem.id;
    var type = widget.tabItem.type;
    try {
      var res =
          await DioRequestWeb.getTopicsByTabKey(type, id, _currentPage + 1);

      _isLoading = false;
    } catch (err) {
      if (_currentPage == 0) {
        setState(() {
          _dioErrorMsg = err.toString();
          _dioError = true;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
