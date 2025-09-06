import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/bookmark_entity.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, List<BookmarkEntity>>> getBookmarks();
  Future<Either<Failure, void>> addBookmark(BookmarkEntity bookmark);
  Future<Either<Failure, void>> removeBookmark(String bookmarkId);
  Future<Either<Failure, void>> updateBookmark(BookmarkEntity bookmark);
  Future<Either<Failure, bool>> isBookmarked(String documentId);
  Future<Either<Failure, List<BookmarkEntity>>> getBookmarksByCategory(
      String category);
  Future<Either<Failure, List<BookmarkEntity>>> searchBookmarks(String query);
}
