import 'package:equatable/equatable.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class DocumentLoadRequested extends DocumentEvent {
  final String documentId;

  const DocumentLoadRequested(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class DocumentBookmarkToggled extends DocumentEvent {
  final String documentId;

  const DocumentBookmarkToggled(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class DocumentSummaryRequested extends DocumentEvent {
  final String documentId;

  const DocumentSummaryRequested(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class DocumentShareRequested extends DocumentEvent {
  final String documentId;

  const DocumentShareRequested(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class DocumentDownloadRequested extends DocumentEvent {
  final String documentId;

  const DocumentDownloadRequested(this.documentId);

  @override
  List<Object> get props => [documentId];
}
