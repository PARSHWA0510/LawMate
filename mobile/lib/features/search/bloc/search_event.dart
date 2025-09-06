import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class SearchSubmitted extends SearchEvent {
  final String query;
  final String? category;
  final String? type;

  const SearchSubmitted({
    required this.query,
    this.category,
    this.type,
  });

  @override
  List<Object> get props => [query, category ?? '', type ?? ''];
}

class SearchFilterChanged extends SearchEvent {
  final String? category;
  final String? type;

  const SearchFilterChanged({
    this.category,
    this.type,
  });

  @override
  List<Object> get props => [category ?? '', type ?? ''];
}

class SearchLoadMore extends SearchEvent {
  const SearchLoadMore();
}

class SearchClear extends SearchEvent {
  const SearchClear();
}

class SearchGetSuggestions extends SearchEvent {
  final String query;

  const SearchGetSuggestions(this.query);

  @override
  List<Object> get props => [query];
}
