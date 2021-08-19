class GameModel {
  GameModel(
      {required this.name,
        required this.description,
        required this.link,
        required this.gameReference,
        required this.image,
        required this.thumbnail,
        required this.score});

  final String name;
  final String description;
  final String link;
  final String gameReference;
  final String image;
  final String thumbnail;
  final List<dynamic> score;

  String imageUrl = "";
  String thumbnailUrl = "";

  double getRating() {
    if(score.length > 0)
      return score.reduce((value, element) => value + element).toDouble();
    else
      return 0.0;
  }

  GameModel.fromJson(Map<String, Object?> json)
      : this(
    name: json['name'] as String,
    description: json['description'] as String,
    link: json['link'] as String,
    gameReference: json["gameReference"] as String,
    image: json['image'] as String,
    thumbnail: json['thumbnail'] as String,
    score: json['score'] as List<dynamic>,
  );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'description': description,
      'link': link,
      'gameReference': gameReference,
      'image': image,
      'thumbnail': thumbnail,
      'score': score,
    };
  }
}