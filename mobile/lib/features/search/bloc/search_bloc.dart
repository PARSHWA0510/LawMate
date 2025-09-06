import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../domain/usecases/search_documents_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchDocumentsUseCase _searchDocumentsUseCase;

  SearchBloc({
    required SearchDocumentsUseCase searchDocumentsUseCase,
  })  : _searchDocumentsUseCase = searchDocumentsUseCase,
        super(const SearchInitial()) {
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchSubmitted>(_onSearchSubmitted);
    on<SearchFilterChanged>(_onFilterChanged);
    on<SearchLoadMore>(_onLoadMore);
    on<SearchClear>(_onClear);
    on<SearchGetSuggestions>(_onGetSuggestions);
  }

  void _onQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) {
    // Handle query changes for real-time suggestions
  }

  Future<void> _onSearchSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoading());

    final result = await _searchDocumentsUseCase(SearchParams(
      query: event.query,
      category: event.category,
      type: event.type,
    ));

    result.fold(
      (failure) => emit(SearchError(message: _mapFailureToMessage(failure))),
      (results) => emit(SearchLoaded(
        results: results,
        hasMore: results.length >= 20, // Assuming 20 is the page size
        query: event.query,
        category: event.category,
        type: event.type,
      )),
    );
  }

  void _onFilterChanged(SearchFilterChanged event, Emitter<SearchState> emit) {
    // Handle filter changes
  }

  Future<void> _onLoadMore(
      SearchLoadMore event, Emitter<SearchState> emit) async {
    // Handle load more functionality
  }

  void _onClear(SearchClear event, Emitter<SearchState> emit) {
    emit(const SearchInitial());
  }

  Future<void> _onGetSuggestions(
    SearchGetSuggestions event,
    Emitter<SearchState> emit,
  ) async {
    // Handle getting search suggestions
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
