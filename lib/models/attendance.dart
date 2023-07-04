import 'package:hive_flutter/hive_flutter.dart';
part 'attendance.g.dart';

@HiveType(typeId: 0)
class Attendance extends HiveObject {
  @HiveField(0)
  final String subj;
  @HiveField(1)
  late final int totalLecs;
  @HiveField(2)
  final int attended;
  @HiveField(3)
  late final int bunked;
  @HiveField(4)
  late final double percentage;
  Attendance(
      {required this.subj,
      required this.percentage,
      required this.bunked,
      required this.attended,
      required this.totalLecs});

  factory Attendance.zeroAttendance(String subject) {
    return Attendance(
      subj: subject,
      percentage: 0,
      totalLecs: 0,
      attended: 0,
      bunked: 0,
    );
  }
}
