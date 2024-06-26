enum DynamicBadgeMode { hidden, point, number }

extension DynamicBadgeModeDesc on DynamicBadgeMode {
  String get description => ['隐藏', '红点', '数字'][index];

  int get code => [0, 1, 2][index];
}
