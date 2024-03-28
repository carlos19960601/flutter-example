import 'package:apidash/consts.dart';
import 'package:apidash/models/name_value_model.dart';

class RequestModel {
  RequestModel({
    required this.id,
    this.method = HTTPVerb.get,
    this.name = "",
    this.url = "",
    this.description = "",
    this.requestHeaders,
    this.requestParams,
    this.requestBodyContentType = ContentType.json,
    this.requestTabIndex = 0,
    this.isParamEnabledList,
  });

  final String id;
  final HTTPVerb method;
  String name;
  final String url;
  final String description;
  final List<NameValueModel>? requestHeaders;
  final List<NameValueModel>? requestParams;
  final ContentType requestBodyContentType;
  int requestTabIndex;
  final List<bool>? isParamEnabledList;

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
    List<NameValueModel>? requestHeaders,
    List<NameValueModel>? requestParams,
    ContentType? requestBodyContentType,
  }) {
    var headers = requestHeaders ?? this.requestHeaders;
    var params = requestParams ?? this.requestParams;

    return RequestModel(
      id: id ?? this.id,
      method: method ?? this.method,
      url: url ?? this.url,
      name: name ?? this.name,
      description: description ?? this.description,
      requestHeaders: headers != null ? [...headers] : null,
      requestParams: params != null ? [...params] : null,
      requestBodyContentType:
          requestBodyContentType ?? this.requestBodyContentType,
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
