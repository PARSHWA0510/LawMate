import 'package:equatable/equatable.dart';

abstract class CompareEvent extends Equatable {
  const CompareEvent();

  @override
  List<Object> get props => [];
}

class CompareDocumentsRequested extends CompareEvent {
  final List<String> documentIds;

  const CompareDocumentsRequested(this.documentIds);

  @override
  List<Object> get props => [documentIds];
}

class CompareLoadRequested extends CompareEvent {
  const CompareLoadRequested();
}

class CompareDeleteRequested extends CompareEvent {
  final String comparisonId;

  const CompareDeleteRequested(this.comparisonId);

  @override
  List<Object> get props => [comparisonId];
}

class CompareClearRequested extends CompareEvent {
  const CompareClearRequested();
}
