import 'dart:convert';

class ReviewModel {
  final String? senderName;
  final String? description;
  final int? rating;
  ReviewModel({
    this.senderName,
    this.description,
    this.rating,
  });

  ReviewModel copyWith({
    String? senderName,
    String? description,
    int? rating,
  }) {
    return ReviewModel(
      senderName: senderName ?? this.senderName,
      description: description ?? this.description,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'description': description,
      'rating': rating,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      senderName: map['senderName'],
      description: map['description'],
      rating: map['rating']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ReviewModel(senderName: $senderName, description: $description, rating: $rating)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel &&
        other.senderName == senderName &&
        other.description == description &&
        other.rating == rating;
  }

  @override
  int get hashCode =>
      senderName.hashCode ^ description.hashCode ^ rating.hashCode;

 
}
