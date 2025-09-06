import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/document_entity.dart';
import '../repositories/document_repository.dart';

@injectable
class GetDocumentUseCase {
  final DocumentRepository repository;

  GetDocumentUseCase(this.repository);

  Future<Either<Failure, DocumentEntity>> call(String documentId) async {
    return await repository.getDocumentById(documentId);
  }
}
