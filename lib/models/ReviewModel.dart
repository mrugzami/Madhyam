import 'dart:convert';

//This Model get created when a new review is created
class ReviewModel {
  String uid;
  String imageUrl;
  String name;
  String reviewText;
  double rating;

  ReviewModel({
    this.uid,
    this.imageUrl,
    this.name,
    this.reviewText,
    this.rating,
  });

  ReviewModel copyWith({
    String uid,
    String imageUrl,
    String name,
    String reviewText,
    double rating,
  }) {
    return ReviewModel(
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      reviewText: reviewText ?? this.reviewText,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'name': name,
      'reviewText': reviewText,
      'rating': rating,
    };
  }

  static ReviewModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    double rating = map['rating'].toDouble();

    return ReviewModel(
      uid: map['uid'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      reviewText: map['reviewText'],
      rating: rating,
    );
  }

  String toJson() => json.encode(toMap());

  static ReviewModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewModel(uid: $uid, imageurl: $imageUrl, name: $name, reviewText: $reviewText, rating: $rating)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReviewModel &&
        o.uid == uid &&
        o.imageUrl == imageUrl &&
        o.name == name &&
        o.reviewText == reviewText &&
        o.rating == rating;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        name.hashCode ^
        reviewText.hashCode ^
        rating.hashCode;
  }
}
