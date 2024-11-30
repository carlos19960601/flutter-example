import 'package:chrono/models/common/picker_result.dart';
import 'package:chrono/models/timer/clock_timer.dart';
import 'package:chrono/pages/timer/widgets/timer_card.dart';
import 'package:chrono/pages/timer/widgets/timer_picker.dart';
import 'package:chrono/widgets/fab.dart';
import 'package:chrono/widgets/list/persistent_list_view.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final _listController = PersistentListController<ClockTimer>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: PersistentListView<ClockTimer>(
                saveTag: "timers",
                listController: _listController,
                itemBuilder: (timer) => const TimerCard(),
              ),
            ),
          ],
        ),
        FAB(
          onPressed: handleAddTimerAction,
        )
      ],
    );
  }

  Future<void> handleAddTimerAction() async {
    PickerResult<ClockTimer>? pickerResult = await showTimerPicker(context);
    if (pickerResult != null) {
      ClockTimer timer = ClockTimer.from(pickerResult.value);
      if (pickerResult.isCustomize) {
      } else {
        await timer.start();
        _listController.addItem(timer);
      }
    }
  }
}
