class PhotosPOJO {
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;
  bool? isLiked;

  PhotosPOJO(
      {this.albumId,
      this.id,
      this.title,
      this.url,
      this.thumbnailUrl,
      this.isLiked = false});

  PhotosPOJO.fromJson(Map<String, dynamic> json)
      : albumId = json['albumId'] as int?,
        id = json['id'] as int?,
        title = json['title'] as String?,
        url = json['url'] as String?,
        thumbnailUrl = json['thumbnailUrl'] as String?,
        isLiked = json['isLiked'] as bool?;

  Map<String, dynamic> toJson() => {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbnailUrl': thumbnailUrl,
        'isLiked': isLiked
      };
}
