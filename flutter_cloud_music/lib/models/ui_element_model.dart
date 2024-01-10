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
}

class TitleText {}

class ElementImage {}

class ElementButton {}
