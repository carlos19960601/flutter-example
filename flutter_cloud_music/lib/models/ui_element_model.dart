class UiElementModel {
  TitleText? mainTitle;
  TitleText? subTitle;
  ElementImage? image;
  ElementButton? button;
  List<String>? labelTexts;
  List<String>? labelUrls;
  String? rcmdShowType;
  String? labelType;

  UiElementModel(
    this.mainTitle,
    this.subTitle,
    this.image,
    this.button,
    this.labelTexts,
    this.labelUrls,
    this.rcmdShowType,
    this.labelType,
  );

  factory UiElementModel.fromJson(Map<String, dynamic> json) => UiElementModel(
        json["mainTitle"] == null
            ? null
            : TitleText.fromJson(json["mainTitle"]),
        json["subTitle"] == null ? null : TitleText.fromJson(json["subTitle"]),
        json["image"] == null ? null : ElementImage.fromJson(json["image"]),
        json['button'] == null ? null : ElementButton.fromJson(json['button']),
        (json["labelTexts"] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        (json["labelUrls"] as List<dynamic>?)?.map((e) => e as String).toList(),
        json['rcmdShowType'] as String?,
        json['labelType'] as String?,
      );
}

class TitleText {
  String? title;
  String? titleType;
  String? titleImgUrl;

  TitleText(this.title, this.titleType, this.titleImgUrl);

  factory TitleText.fromJson(Map<String, dynamic> json) => TitleText(
        json["title"],
        json["titleType"],
        json["titleImgUrl"],
      );
}

class ElementImage {
  String? imageUrl;

  ElementImage(
    this.imageUrl,
  );

  factory ElementImage.fromJson(Map<String, dynamic> json) =>
      ElementImage(json["imageUrl"]);
}

class ElementButton {
  String? action;
  String? actionType;
  String? text;
  String? iconUrl;

  ElementButton(
    this.action,
    this.actionType,
    this.text,
    this.iconUrl,
  );

  factory ElementButton.fromJson(Map<String, dynamic> json) => ElementButton(
        json['action'] as String?,
        json['actionType'] as String?,
        json['text'] as String?,
        json['iconUrl'] as String?,
      );
}
