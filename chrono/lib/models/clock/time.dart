enum TimeFormat {
  h24,
  h12,
  device,
}

extension TimeFormatCode on TimeFormat {
  int get code => [0, 1, 2][index];
}
