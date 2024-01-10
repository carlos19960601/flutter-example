class Api {
  static const String homeFound = "/homepage/block/page";
}

class ApiResponse<T> {
  bool status;
  T? data;
  String? message;

  ApiResponse({required this.status, this.data, this.message});
}
