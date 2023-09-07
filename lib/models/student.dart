import 'package:hive_flutter/hive_flutter.dart';
part 'student.g.dart';

@HiveType(typeId: 1)
class Student extends HiveObject {
  @HiveField(0)
  final int xieID;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String year;
  @HiveField(4)
  final int rollNo;

  Student(this.xieID, this.fullName, this.email, this.year, this.rollNo);
}
