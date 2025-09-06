import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final String type; // 'law', 'policy', 'scheme'
  final String category;
  final String source;
  final DateTime publishedDate;
  final DateTime? lastUpdated;
  final List<String> tags;
  final String? summary;
  final String? documentUrl;
  final int? pageCount;
  final String? language;
  final bool isBookmarked;

  const DocumentEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.category,
    required this.source,
    required this.publishedDate,
    this.lastUpdated,
    required this.tags,
    this.summary,
    this.documentUrl,
    this.pageCount,
    this.language,
    this.isBookmarked = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        type,
        category,
        source,
        publishedDate,
        lastUpdated,
        tags,
        summary,
        documentUrl,
        pageCount,
        language,
        isBookmarked,
      ];
}
