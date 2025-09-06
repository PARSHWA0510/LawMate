import 'package:equatable/equatable.dart';
import '../domain/entities/search_result_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final List<SearchResultEntity> results;
  final bool hasMore;
  final String query;
  final String? category;
  final String? type;

  const SearchLoaded({
    required this.results,
    required this.hasMore,
    required this.query,
    this.category,
    this.type,
  });

  @override
  List<Object?> get props => [results, hasMore, query, category, type];
}

class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchSuggestionsLoaded extends SearchState {
  final List<String> suggestions;

  const SearchSuggestionsLoaded({required this.suggestions});

  @override
  List<Object> get props => [suggestions];
}
