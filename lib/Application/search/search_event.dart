part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class InputEvent extends SearchEvent {
  final String searchInput;

  const InputEvent({required this.searchInput});
}

class ClearInputEvent extends SearchEvent {}
