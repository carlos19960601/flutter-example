class Api {
  static const String homeFound = "/homepage/block/page";
  static const String playlistDetail = "/playlist/detail";
  static const String songDetail = "/song/detail";
  static const String songUrl = "/song/url";
}

class ApiResponse<T> {
  bool status;
  T? data;
  String? message;

  ApiResponse({required this.status, this.data, this.message});
}
