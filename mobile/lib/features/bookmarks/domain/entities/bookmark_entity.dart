import 'package:equatable/equatable.dart';

class BookmarkEntity extends Equatable {
  final String id;
  final String documentId;
  final String title;
  final String description;
  final String type;
  final String category;
  final DateTime bookmarkedAt;
  final String? notes;
  final List<String> tags;

  const BookmarkEntity({
    required this.id,
    required this.documentId,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.bookmarkedAt,
    this.notes,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        id,
        documentId,
        title,
        description,
        type,
        category,
        bookmarkedAt,
        notes,
        tags,
      ];
}
