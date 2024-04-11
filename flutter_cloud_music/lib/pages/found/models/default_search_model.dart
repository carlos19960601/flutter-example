class DefaultSearchModel {
  String? showKeyword;
  String? realKeyword;
  int? searchType;

  DefaultSearchModel({
    this.showKeyword,
    this.realKeyword,
    this.searchType,
  });

  factory DefaultSearchModel.fromJson(Map<String, dynamic> json) =>
      DefaultSearchModel(
        showKeyword: json["showKeyword"],
        realKeyword: json["realKeyword"],
        searchType: json["searchType"],
      );
}
