class NameValueModel {
  final String? name;
  final String? value;

  NameValueModel({this.name, this.value});

  factory NameValueModel.fromJson(Map<String, dynamic> json) => NameValueModel(
        name: json["name"],
        value: json["value"],
      );
}

NameValueModel kNameValueEmptyModel = NameValueModel(name: "", value: "");
