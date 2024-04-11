class ArtistsModel {
  List<Artists> artists;
  bool more;

  ArtistsModel(
    this.artists,
    this.more,
  );

  factory ArtistsModel.fromJson(Map<String, dynamic> json) => ArtistsModel(
        (json['artists'] as List<dynamic>)
            .map((e) => Artists.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['more'] as bool,
      );
}

class Artists extends Object {
  int? accountId;
  int albumSize;
  List<String> alias;
  bool followed;
  int id;
  String img1v1Url;
  String name;
  String? trans;
  int? mvSize;
  String? identityIconUrl;

  Artists(this.accountId, this.albumSize, this.alias, this.followed, this.id,
      this.img1v1Url, this.name, this.trans, this.mvSize, this.identityIconUrl);

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        json['accountId'] as int?,
        json['albumSize'] as int,
        (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
        json['followed'] as bool,
        json['id'] as int,
        json['img1v1Url'] as String,
        json['name'] as String,
        json['trans'] as String?,
        json['mvSize'] as int?,
        json['identityIconUrl'] as String?,
      );

  String getArName() {
    if (trans != null && trans!.isNotEmpty) {
      return '$name（$trans）';
    } else if (alias.isNotEmpty) {
      return '$name（${alias.join('/')}）';
    } else {
      return name;
    }
  }

  String? getExtraStr() {
    if (trans != null && trans!.isNotEmpty) {
      return '（$trans）';
    } else if (alias.isNotEmpty) {
      return '（${alias.join('/')}）';
    }
    return null;
  }
}
