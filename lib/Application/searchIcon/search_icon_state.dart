part of 'search_icon_cubit.dart';

@immutable
abstract class SearchIconState extends Equatable {
  const SearchIconState();

  @override
  List<Object> get props => [];
}

class IconCubitChange extends SearchIconState {
  final IconData iconData;
  const IconCubitChange({required this.iconData});

  @override
  List<Object> get props => [iconData];
}
