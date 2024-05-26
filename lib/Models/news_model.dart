
class NewsArticle {
  final String source;
  final String name;
  final String title;
  final String description;
  final String publishedAt;
  final String content;
  final bool bookmark;
  NewsArticle({
    required this.source,
    required this.name,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.content,
    required this.bookmark,
  });
   factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(source: json['source']!['name']??"-", name: json["name"] ?? "-", title: json["title"] ?? "-", description: json["description"] ?? "-", publishedAt: json["publishedAt"] ?? "-", content: json["content"] ?? "-",bookmark: json["bookmark"]);
   }

NewsArticle copyWith({
    String? source,
    String? name,
    String? title,
    String? description,
    String? publishedAt,
    String? content,
    bool? bookmark,
  }) {
    return NewsArticle(
      source: source ?? this.source,
      name: name ?? this.name,
      title: title ?? this.title,
      description: description ?? this.description,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      bookmark: bookmark ?? this.bookmark,
    );
  }
}
