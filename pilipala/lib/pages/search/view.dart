import 'package:animations/animations.dart';
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
      openBuilder: (context, action) {
        return Scaffold();
      },
      closedBuilder: (context, action) {
        return Container(
          width: 250,
          height: 44,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
            Radius.circular(25),
          )),
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
                child: Text("Search"),
              )
            ],
          ),
        );
      },
    );
  }
}
