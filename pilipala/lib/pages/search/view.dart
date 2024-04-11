import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/common/widgets/http_error.dart';
import 'package:pilipala/pages/search/controller.dart';
import 'package:pilipala/pages/search/widgets/hot_keyword.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SSearchController _searchController = Get.put(SSearchController());
  late Future? _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _searchController.queryHotSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Theme.of(context).colorScheme.background,
      middleColor: Theme.of(context).colorScheme.background,
      closedColor: Theme.of(context).colorScheme.background,
      openBuilder: (context, action) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Hero(
                tag: 'searchTag',
                child: IconButton(
                    onPressed: () => _searchController.submit(),
                    icon: const Icon(CupertinoIcons.search, size: 22)),
              ),
              const SizedBox(width: 10)
            ],
            title: Obx(
              () => TextField(
                autofocus: true,
                focusNode: _searchController.searchFocusNode,
                controller: _searchController.controller.value,
                textInputAction: TextInputAction.search,
                onChanged: (value) => _searchController.onChange(value),
                decoration: InputDecoration(
                  hintText: _searchController.hintText,
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 22,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    onPressed: () => _searchController.onClear(),
                  ),
                ),
                onSubmitted: (String value) => _searchController.submit(),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                _searchSuggest(),
                //热搜
                Visibility(
                  visible: _searchController.enableHotKey,
                  child: hotSearch(_searchController),
                ),
                _history(),
              ],
            ),
          ),
        );
      },
      closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      openShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      closedBuilder: (context, action) {
        return Container(
          height: 44,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              const SizedBox(
                width: 14,
              ),
              Icon(
                Icons.search_outlined,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              Expanded(
                child: Text(
                  "Search",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _searchSuggest() {
    SSearchController _ssCtr = _searchController;
    return Obx(
      () => _ssCtr.searchSuggestList.isNotEmpty &&
              _ssCtr.searchSuggestList.first.term != null &&
              _ssCtr.controller.value.text != ''
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _ssCtr.searchSuggestList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onTap: () => _ssCtr
                      .onClickKeyword(_ssCtr.searchSuggestList[index].term!),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 9, bottom: 9),
                    child: _ssCtr.searchSuggestList[index].textRich,
                  ),
                );
              },
            )
          : const SizedBox(),
    );
  }

  Widget _history() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 25, 6, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(6, 0, 0, 2),
            child: Text("history"),
          ),
        ],
      ),
    );
  }

  Widget hotSearch(SSearchController ctr) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 14, 4, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 6),
            child: Row(
              children: [
                Text(
                  '大家都在搜',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 34,
                  child: TextButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 10, top: 6, bottom: 6, right: 10)),
                    ),
                    onPressed: () => ctr.queryHotSearchList(),
                    icon: const Icon(Icons.refresh_outlined, size: 18),
                    label: const Text('刷新'),
                  ),
                ),
              ],
            ),
          ),
          LayoutBuilder(builder: (context, boxConstraints) {
            final double width = boxConstraints.maxWidth;
            return FutureBuilder(
                future: _futureBuilderFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    }
                    Map data = snapshot.data as Map;
                    if (data['status']) {
                      return Obx(
                        () => HotKeyword(
                          width: width,
                          hotSearchList: _searchController.hotSearchList.value,
                          onClick: (keyword) async {
                            _searchController.searchFocusNode.unfocus();
                            await Future.delayed(
                                const Duration(milliseconds: 150));
                            _searchController.onClickKeyword(keyword);
                          },
                        ),
                      );
                    } else {
                      return HttpError(
                        errMsg: data['msg'],
                        fn: () => setState(() {}),
                      );
                    }
                  } else {
                    // 缓存数据
                    if (_searchController.hotSearchList.isNotEmpty) {
                      return HotKeyword(
                        width: width,
                        hotSearchList: _searchController.hotSearchList,
                      );
                    } else {
                      return const SizedBox();
                    }
                  }
                });
          })
        ],
      ),
    );
  }
}
