import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../domain/repositories/comparison_repository.dart';
import 'compare_event.dart';
import 'compare_state.dart';

@injectable
class CompareBloc extends Bloc<CompareEvent, CompareState> {
  final ComparisonRepository _comparisonRepository;

  CompareBloc({
    required ComparisonRepository comparisonRepository,
  })  : _comparisonRepository = comparisonRepository,
        super(const CompareInitial()) {
    on<CompareDocumentsRequested>(_onCompareDocumentsRequested);
    on<CompareLoadRequested>(_onCompareLoadRequested);
    on<CompareDeleteRequested>(_onCompareDeleteRequested);
    on<CompareClearRequested>(_onCompareClearRequested);
  }

  Future<void> _onCompareDocumentsRequested(
    CompareDocumentsRequested event,
    Emitter<CompareState> emit,
  ) async {
    emit(const CompareLoading());

    final result =
        await _comparisonRepository.createComparison(event.documentIds);

    result.fold(
      (failure) => emit(CompareError(message: _mapFailureToMessage(failure))),
      (comparison) => emit(CompareLoaded(
        comparisons: const [],
        currentComparison: comparison,
      )),
    );
  }

  Future<void> _onCompareLoadRequested(
    CompareLoadRequested event,
    Emitter<CompareState> emit,
  ) async {
    // Implement comparison loading
  }

  Future<void> _onCompareDeleteRequested(
    CompareDeleteRequested event,
    Emitter<CompareState> emit,
  ) async {
    // Implement comparison deletion
  }

  void _onCompareClearRequested(
    CompareClearRequested event,
    Emitter<CompareState> emit,
  ) {
    emit(const CompareInitial());
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
