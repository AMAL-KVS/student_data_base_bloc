import 'package:hive/hive.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  String location;

  @HiveField(3)
  final String qualificcation;

  @HiveField(4)
  final int? id;

  @HiveField(5)
  final String? imagepath;

  StudentModel(
      {required this.name,
      required this.age,
      required this.location,
      required this.qualificcation,
      this.id,
      this.imagepath});
  @override
  Future<void> delete() {
    // ignore: todo
    // TODO: implement delete
    return super.delete();
  }
}
