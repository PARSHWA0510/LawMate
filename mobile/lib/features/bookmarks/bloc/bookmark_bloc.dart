import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../domain/repositories/bookmark_repository.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

@injectable
class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final BookmarkRepository _bookmarkRepository;

  BookmarkBloc({
    required BookmarkRepository bookmarkRepository,
  })  : _bookmarkRepository = bookmarkRepository,
        super(const BookmarkInitial()) {
    on<BookmarkLoadRequested>(_onBookmarkLoadRequested);
    on<BookmarkAdded>(_onBookmarkAdded);
    on<BookmarkRemoved>(_onBookmarkRemoved);
    on<BookmarkUpdated>(_onBookmarkUpdated);
    on<BookmarkSearchRequested>(_onBookmarkSearchRequested);
  }

  Future<void> _onBookmarkLoadRequested(
    BookmarkLoadRequested event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const BookmarkLoading());

    final result = await _bookmarkRepository.getBookmarks();

    result.fold(
      (failure) => emit(BookmarkError(message: _mapFailureToMessage(failure))),
      (bookmarks) => emit(BookmarkLoaded(bookmarks: bookmarks)),
    );
  }

  Future<void> _onBookmarkAdded(
    BookmarkAdded event,
    Emitter<BookmarkState> emit,
  ) async {
    // Implement bookmark addition logic
  }

  Future<void> _onBookmarkRemoved(
    BookmarkRemoved event,
    Emitter<BookmarkState> emit,
  ) async {
    // Implement bookmark removal logic
  }

  Future<void> _onBookmarkUpdated(
    BookmarkUpdated event,
    Emitter<BookmarkState> emit,
  ) async {
    // Implement bookmark update logic
  }

  Future<void> _onBookmarkSearchRequested(
    BookmarkSearchRequested event,
    Emitter<BookmarkState> emit,
  ) async {
    // Implement bookmark search logic
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        return failure.message;
      case NetworkFailure _:
        return failure.message;
      case ValidationFailure _:
        return failure.message;
      default:
        return 'An unexpected error occurred.';
    }
  }
}
