import 'package:equatable/equatable.dart';
import '../domain/entities/comparison_entity.dart';

abstract class CompareState extends Equatable {
  const CompareState();

  @override
  List<Object?> get props => [];
}

class CompareInitial extends CompareState {
  const CompareInitial();
}

class CompareLoading extends CompareState {
  const CompareLoading();
}

class CompareLoaded extends CompareState {
  final List<ComparisonEntity> comparisons;
  final ComparisonEntity? currentComparison;

  const CompareLoaded({
    required this.comparisons,
    this.currentComparison,
  });

  @override
  List<Object?> get props => [comparisons, currentComparison];
}

class CompareError extends CompareState {
  final String message;

  const CompareError({required this.message});

  @override
  List<Object> get props => [message];
}
