import 'package:apidash/consts.dart';

class RequestModel {
  RequestModel({
    required this.id,
    this.method = HTTPVerb.get,
    this.name = "",
    this.url = "",
    this.description = "",
  });

  final String id;
  final HTTPVerb method;
  String name;
  final String url;
  final String description;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "method": method.name,
      "url": url,
      "name": name,
      "description": description,
    };
  }

  RequestModel copyWith({
    String? id,
    HTTPVerb? method,
    String? url,
    String? name,
    String? description,
  }) {
    return RequestModel(
      id: id ?? this.id,
      method: method ?? this.method,
      url: url ?? this.url,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  factory RequestModel.fromJson(Map<String, dynamic> data) {
    HTTPVerb method;

    final id = data["id"] as String;
    try {
      method = HTTPVerb.values.byName(data["method"] as String);
    } catch (e) {
      method = kDefaultHttpMethod;
    }
    final url = data["url"] as String;
    final name = data["name"] as String?;

    return RequestModel(
      id: id,
      method: method,
      url: url,
      name: name ?? "",
    );
  }
}
