import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_data_base/model/d_b_functions.dart';
import 'package:student_data_base/model/db_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchResultState(studentlist: DBFunctions.getStudents())) {
    on<SearchEvent>((event, emit) {
      if (event is InputEvent) {
        List<StudentModel> studentData = DBFunctions.getStudents()
            .where((element) => element.name
                .toLowerCase()
                .contains(event.searchInput.toLowerCase()))
            .toList();
        emit(
          SearchResultState(studentlist: studentData),
        );
        if (event is ClearInputEvent) {
          emit(SearchResultState(studentlist: DBFunctions.getStudents()));
        }
      }
    });
  }
}
