import 'package:equatable/equatable.dart';

class SearchResultEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String type; // 'law', 'policy', 'scheme'
  final String category;
  final String source;
  final DateTime publishedDate;
  final List<String> tags;
  final String? documentUrl;
  final String? summary;

  const SearchResultEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.source,
    required this.publishedDate,
    required this.tags,
    this.documentUrl,
    this.summary,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        category,
        source,
        publishedDate,
        tags,
        documentUrl,
        summary,
      ];
}
