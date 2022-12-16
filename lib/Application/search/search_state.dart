part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchResultState extends SearchState {
  final List<StudentModel> studentlist;
  const SearchResultState({required this.studentlist});
}
