
class Rating {
  final int id;
  final String content;
  final String dateCreated;
  final int rating;

  Rating({
    required this.id,
    required this.dateCreated,
    required this.content,
    this.rating = 0,
    
  });

  factory Rating.fromJson(Map json) {

    return Rating(
      id: json['id'],
      dateCreated: json['date_created'],
      content: json['content'],
      rating: json["rating"] ?? 0,
    );
  }
}