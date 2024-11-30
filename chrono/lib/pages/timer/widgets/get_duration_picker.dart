import 'package:chrono/core/app_extension.dart';
import 'package:chrono/models/common/duration_picker_type.dart';
import 'package:chrono/models/common/time_duration.dart';
import 'package:flutter/cupertino.dart';

Widget getDurationPicker(
  BuildContext context,
  DurationPickerType type,
  TimeDuration duration,
  void Function(TimeDuration) onDurationChange,
) {
  Widget picker;

  switch (type) {
    case DurationPickerType.spinner:
      picker = SizedBox(
        height: 220,
        width: context.mediaQueryData.size.width - 64,
        child: CupertinoTheme(
          data: const CupertinoThemeData(),
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hms,
            initialTimerDuration: Duration(seconds: duration.inSeconds),
            onTimerDurationChanged: (Duration duration) {
              onDurationChange(duration.toTimeDuration());
            },
          ),
        ),
      );
      break;
    case DurationPickerType.rings:
      picker = const Text("");
    case DurationPickerType.numpad:
      picker = const Text("");
  }

  return picker;
}
