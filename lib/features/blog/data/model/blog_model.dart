import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.url,
    required super.topics,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': url,
      'topic': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'],
      posterId: map['poster_id'],
      title: map['title'],
      content: map['content'],
      url: map['image_url'],
      topics: List<String>.from(map['topic'] ?? []),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }
  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? url,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      url: url ?? this.url,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
