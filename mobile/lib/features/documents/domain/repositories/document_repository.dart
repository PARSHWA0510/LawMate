import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/document_entity.dart';

abstract class DocumentRepository {
  Future<Either<Failure, DocumentEntity>> getDocumentById(String id);
  Future<Either<Failure, List<DocumentEntity>>> getRecentDocuments();
  Future<Either<Failure, List<DocumentEntity>>> getPopularDocuments();
  Future<Either<Failure, List<DocumentEntity>>> getDocumentsByCategory(
      String category);
  Future<Either<Failure, List<DocumentEntity>>> getDocumentsByType(String type);
  Future<Either<Failure, String>> getDocumentSummary(String id);
  Future<Either<Failure, void>> bookmarkDocument(String id);
  Future<Either<Failure, void>> unbookmarkDocument(String id);
  Future<Either<Failure, List<DocumentEntity>>> getBookmarkedDocuments();
}
