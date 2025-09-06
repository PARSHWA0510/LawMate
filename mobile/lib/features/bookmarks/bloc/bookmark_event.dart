import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class BookmarkLoadRequested extends BookmarkEvent {
  const BookmarkLoadRequested();
}

class BookmarkAdded extends BookmarkEvent {
  final String documentId;
  final String title;
  final String description;
  final String type;
  final String category;

  const BookmarkAdded({
    required this.documentId,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
  });

  @override
  List<Object> get props => [documentId, title, description, type, category];
}

class BookmarkRemoved extends BookmarkEvent {
  final String bookmarkId;

  const BookmarkRemoved(this.bookmarkId);

  @override
  List<Object> get props => [bookmarkId];
}

class BookmarkUpdated extends BookmarkEvent {
  final String bookmarkId;
  final String? notes;
  final List<String>? tags;

  const BookmarkUpdated({
    required this.bookmarkId,
    this.notes,
    this.tags,
  });

  @override
  List<Object> get props => [bookmarkId, notes ?? '', tags ?? []];
}

class BookmarkSearchRequested extends BookmarkEvent {
  final String query;

  const BookmarkSearchRequested(this.query);

  @override
  List<Object> get props => [query];
}
