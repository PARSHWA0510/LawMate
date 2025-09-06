import 'package:equatable/equatable.dart';
import '../domain/entities/bookmark_entity.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object?> get props => [];
}

class BookmarkInitial extends BookmarkState {
  const BookmarkInitial();
}

class BookmarkLoading extends BookmarkState {
  const BookmarkLoading();
}

class BookmarkLoaded extends BookmarkState {
  final List<BookmarkEntity> bookmarks;

  const BookmarkLoaded({required this.bookmarks});

  @override
  List<Object> get props => [bookmarks];
}

class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError({required this.message});

  @override
  List<Object> get props => [message];
}

class BookmarkAddedSuccess extends BookmarkState {
  final BookmarkEntity bookmark;

  const BookmarkAddedSuccess({required this.bookmark});

  @override
  List<Object> get props => [bookmark];
}

class BookmarkRemovedSuccess extends BookmarkState {
  final String bookmarkId;

  const BookmarkRemovedSuccess({required this.bookmarkId});

  @override
  List<Object> get props => [bookmarkId];
}
