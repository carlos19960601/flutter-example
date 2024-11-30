import 'package:chrono/models/clock/city.dart';
import 'package:chrono/pages/clock/widgets/timezone_card.dart';
import 'package:chrono/widgets/fab.dart';
import 'package:chrono/widgets/list/persistent_list_view.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  final _listController = PersistentListController<City>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            Expanded(
              child: PersistentListView<City>(
                saveTag: "favorite_cities",
                listController: _listController,
                itemBuilder: (city) => TimeZoneCard(city: city as City),
              ),
            )
          ],
        ),
        const FAB(),
      ],
    );
  }
}
