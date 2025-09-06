import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultEntity>>> searchDocuments(
      String query);
  Future<Either<Failure, List<SearchResultEntity>>> searchByCategory(
      String category);
  Future<Either<Failure, List<SearchResultEntity>>> searchByType(String type);
  Future<Either<Failure, SearchResultEntity>> getDocumentById(String id);
  Future<Either<Failure, List<String>>> getSearchSuggestions(String query);
  Future<Either<Failure, List<String>>> getPopularSearches();
}
