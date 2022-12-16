import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'search_icon_state.dart';

class SearchIconCubit extends Cubit<SearchIconState> {
  SearchIconCubit() : super(const IconCubitChange(iconData: Icons.search));

  void changeIcon(IconData iconData) {
    if (iconData == Icons.search) {
      emit(const IconCubitChange(iconData: Icons.close));
    } else {
      emit(const IconCubitChange(iconData: Icons.search));
    }
  }
}
