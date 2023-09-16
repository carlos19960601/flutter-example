import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.search,
                  size: 22,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                _history(),
              ],
            ),
          ),
        );
      },
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
}
