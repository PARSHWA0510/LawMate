import 'package:equatable/equatable.dart';
import '../domain/entities/document_entity.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentInitial extends DocumentState {
  const DocumentInitial();
}

class DocumentLoading extends DocumentState {
  const DocumentLoading();
}

class DocumentLoaded extends DocumentState {
  final DocumentEntity document;
  final String? summary;

  const DocumentLoaded({
    required this.document,
    this.summary,
  });

  @override
  List<Object?> get props => [document, summary];
}

class DocumentError extends DocumentState {
  final String message;

  const DocumentError({required this.message});

  @override
  List<Object> get props => [message];
}

class DocumentBookmarked extends DocumentState {
  final String documentId;
  final bool isBookmarked;

  const DocumentBookmarked({
    required this.documentId,
    required this.isBookmarked,
  });

  @override
  List<Object> get props => [documentId, isBookmarked];
}

class DocumentSummaryLoaded extends DocumentState {
  final String documentId;
  final String summary;

  const DocumentSummaryLoaded({
    required this.documentId,
    required this.summary,
  });

  @override
  List<Object> get props => [documentId, summary];
}
