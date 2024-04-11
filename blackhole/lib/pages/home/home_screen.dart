import 'package:blackhole/pages/home/saavn.dart';
import 'package:blackhole/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blackhole/localization/translation_keys.dart'
    as translation_keys;
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  Box settings = GStorage.setting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 135,
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 65,
                  flexibleSpace: FlexibleSpaceBar(
                    background: GestureDetector(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  translation_keys.homeGreet.tr,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 30,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Text(
                                  settings.get("name", defaultValue: "Guest"),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  stretch: true,
                  elevation: 0,
                  toolbarHeight: 65,
                  backgroundColor: Colors.transparent,
                  title: Align(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/search", arguments: {
                          "fromHome": true,
                          "autoFocus": true,
                        });
                      },
                      child: AnimatedContainer(
                        height: 55,
                        duration: const Duration(
                          microseconds: 150,
                        ),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).cardColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1.5, 1.5),
                                blurRadius: 5,
                              ),
                            ]),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              CupertinoIcons.search,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              translation_keys.searchText.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: const SaavnHomePage(),
          )
        ],
      ),
    );
  }
}
