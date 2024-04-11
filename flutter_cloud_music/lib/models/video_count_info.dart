class VideoCountInfo extends Object {
  int likedCount;
  int shareCount;
  int commentCount;

  VideoCountInfo(
    this.likedCount,
    this.shareCount,
    this.commentCount,
  );

  factory VideoCountInfo.fromJson(Map<String, dynamic> json) => VideoCountInfo(
        json['likedCount'] as int,
        json['shareCount'] as int,
        json['commentCount'] as int,
      );
}
