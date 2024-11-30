import 'package:chrono/core/app_extension.dart';
import 'package:chrono/models/common/duration_picker_type.dart';
import 'package:chrono/models/common/picker_result.dart';
import 'package:chrono/models/common/time_duration.dart';
import 'package:chrono/models/timer/clock_timer.dart';
import 'package:chrono/pages/timer/widgets/get_duration_picker.dart';
import 'package:chrono/widgets/modal.dart';
import 'package:flutter/material.dart';

Future<PickerResult<ClockTimer>?> showTimerPicker(
  BuildContext context, {
  ClockTimer? initialTimer,
}) async {
  return showDialog<PickerResult<ClockTimer>>(
    context: context,
    builder: (BuildContext context) {
      ClockTimer timer =
          ClockTimer.from(initialTimer ?? ClockTimer(TimeDuration(minutes: 0)));

      return OrientationBuilder(
        builder: (context, orientation) => StatefulBuilder(
          builder: (context, setState) {
            DurationPickerType type = DurationPickerType.spinner;

            Widget title() {
              return Row(
                children: [
                  Text(
                    "选择时长",
                    style: context.labelSmall,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "模式",
                      style: context.titleSmall?.copyWith(
                        color: context.primary,
                      ),
                    ),
                  )
                ],
              );
            }

            Widget durationPicker() =>
                getDurationPicker(context, type, timer.duration,
                    (TimeDuration newDuration) {
                  setState(() {
                    timer = ClockTimer(newDuration);
                  });
                });

            return Modal(
              onSave: () {
                Navigator.of(context).pop(PickerResult(timer, false));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  title(),
                  const SizedBox(height: 16),
                  durationPicker(),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
