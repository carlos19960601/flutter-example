import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/models/common/search_type.dart';
import 'package:pilipala/pages/searchPanel/view.dart';
import 'package:pilipala/pages/searchResult/controller.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with TickerProviderStateMixin {
  late SearchResultController? _searchResultController;
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _searchResultController = Get.put(SearchResultController(),
        tag: DateTime.now().millisecondsSinceEpoch.toString());
    _tabController = TabController(
      vsync: this,
      length: SearchType.values.length,
      initialIndex: _searchResultController!.tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).dividerColor.withOpacity(0.08),
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: GestureDetector(
          onTap: () => Get.back(),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              '${_searchResultController!.keyword}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 8),
            color: Theme.of(context).colorScheme.surface,
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent, // 点击时的水波纹颜色设置为透明
                highlightColor: Colors.transparent, // 点击时的背景高亮颜色设置为透明
              ),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  for (var i in SearchType.values) Tab(text: i.label),
                ],
                isScrollable: true,
                // indicatorWeight: 0,
                // indicatorPadding:
                //     const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                // indicator: BoxDecoration(
                //   color: Theme.of(context).colorScheme.secondaryContainer,
                //   borderRadius: const BorderRadius.all(Radius.circular(20)),
                // ),
                labelColor: Theme.of(context).colorScheme.onSecondaryContainer,
                labelStyle: const TextStyle(fontSize: 13),
                dividerColor: Colors.transparent,
                unselectedLabelColor: Theme.of(context).colorScheme.outline,
                onTap: (index) {
                  if (index == _searchResultController!.tabIndex) {}
                  _searchResultController!.tabIndex = index;
                },
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                for (var i in SearchType.values) ...{
                  SearchPanel(
                    keyword: _searchResultController!.keyword,
                    searchType: i,
                    tag: DateTime.now().millisecondsSinceEpoch.toString(),
                  )
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}
