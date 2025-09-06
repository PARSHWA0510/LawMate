import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/comparison_entity.dart';

abstract class ComparisonRepository {
  Future<Either<Failure, ComparisonEntity>> createComparison(
      List<String> documentIds);
  Future<Either<Failure, List<ComparisonEntity>>> getComparisons();
  Future<Either<Failure, ComparisonEntity>> getComparisonById(String id);
  Future<Either<Failure, void>> deleteComparison(String id);
  Future<Either<Failure, Map<String, dynamic>>> compareDocuments(
      List<String> documentIds);
}
