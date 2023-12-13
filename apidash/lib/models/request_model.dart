import 'package:apidash/consts.dart';

class RequestModel {
  RequestModel({
    required this.id,
    this.method = HTTPVerb.get,
    this.name = "",
    this.url = "",
  });

  final String id;
  final HTTPVerb method;
  String name;
  final String url;
}
