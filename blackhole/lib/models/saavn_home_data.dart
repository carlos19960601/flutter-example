class SaavnHomeData {
  List<Trending>? newTrendings;

  SaavnHomeData({
    this.newTrendings,
  });

  factory SaavnHomeData.fromJson(Map<String, dynamic> json) {
    return SaavnHomeData(
      newTrendings: List<Trending>.from(
          json["new_trending"].map((x) => Trending.fromJson(x))),
    );
  }
}

class Trending {
  String type;
  Details details;
  double weight;
  String language;

  Trending({
    required this.type,
    required this.details,
    required this.weight,
    required this.language,
  });

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        type: json["type"],
        details: Details.fromJson(json["details"]),
        weight: json["weight"].toDouble(),
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "details": details.toJson(),
        "weight": weight,
        "language": language,
      };
}

class Details {
  String? title;
  String? secondarySubtitle;
  String? image;
  String? albumid;
  String? releaseDate;
  String? songCount;
  String? language;
  String? permaUrl;
  Artist? artist;

  Details({
    this.title,
    this.secondarySubtitle,
    this.image,
    this.albumid,
    this.releaseDate,
    this.songCount,
    this.language,
    this.permaUrl,
    this.artist,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        title: json["title"],
        secondarySubtitle: json["secondary_subtitle"],
        image: json["image"],
        albumid: json["albumid"],
        releaseDate: json["release_date"],
        songCount: json["song_count"],
        language: json["language"],
        permaUrl: json["perma_url"],
        artist: Artist.fromJson(json["artist"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "secondary_subtitle": secondarySubtitle,
        "image": image,
        "albumid": albumid,
        "release_date": releaseDate,
        "song_count": songCount,
        "language": language,
        "perma_url": permaUrl,
        "artist": artist?.toJson(),
      };
}

class Artist {
  String? id;
  String? name;

  Artist({
    this.id,
    this.name,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
