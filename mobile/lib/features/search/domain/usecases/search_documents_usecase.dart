import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_result_entity.dart';
import '../repositories/search_repository.dart';

@injectable
class SearchDocumentsUseCase {
  final SearchRepository repository;

  SearchDocumentsUseCase(this.repository);

  Future<Either<Failure, List<SearchResultEntity>>> call(
      SearchParams params) async {
    return await repository.searchDocuments(params.query);
  }
}

class SearchParams {
  final String query;
  final String? category;
  final String? type;
  final int page;
  final int limit;

  SearchParams({
    required this.query,
    this.category,
    this.type,
    this.page = 1,
    this.limit = 20,
  });
}
