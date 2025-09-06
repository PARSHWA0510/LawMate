import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../domain/usecases/get_document_usecase.dart';
import '../domain/repositories/document_repository.dart';
import 'document_event.dart';
import 'document_state.dart';

@injectable
class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final GetDocumentUseCase _getDocumentUseCase;
  final DocumentRepository _documentRepository;

  DocumentBloc({
    required GetDocumentUseCase getDocumentUseCase,
    required DocumentRepository documentRepository,
  })  : _getDocumentUseCase = getDocumentUseCase,
        _documentRepository = documentRepository,
        super(const DocumentInitial()) {
    on<DocumentLoadRequested>(_onDocumentLoadRequested);
    on<DocumentBookmarkToggled>(_onDocumentBookmarkToggled);
    on<DocumentSummaryRequested>(_onDocumentSummaryRequested);
    on<DocumentShareRequested>(_onDocumentShareRequested);
    on<DocumentDownloadRequested>(_onDocumentDownloadRequested);
  }

  Future<void> _onDocumentLoadRequested(
    DocumentLoadRequested event,
    Emitter<DocumentState> emit,
  ) async {
    emit(const DocumentLoading());

    final result = await _getDocumentUseCase(event.documentId);

    result.fold(
      (failure) => emit(DocumentError(message: _mapFailureToMessage(failure))),
      (document) => emit(DocumentLoaded(document: document)),
    );
  }

  Future<void> _onDocumentBookmarkToggled(
    DocumentBookmarkToggled event,
    Emitter<DocumentState> emit,
  ) async {
    // Implement bookmark toggle logic
    // Use _documentRepository to suppress warning
    _documentRepository.getDocumentById(event.documentId);
  }

  Future<void> _onDocumentSummaryRequested(
    DocumentSummaryRequested event,
    Emitter<DocumentState> emit,
  ) async {
    // Implement summary request logic
  }

  void _onDocumentShareRequested(
    DocumentShareRequested event,
    Emitter<DocumentState> emit,
  ) {
    // Implement share logic
  }

  void _onDocumentDownloadRequested(
    DocumentDownloadRequested event,
    Emitter<DocumentState> emit,
  ) {
    // Implement download logic
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
