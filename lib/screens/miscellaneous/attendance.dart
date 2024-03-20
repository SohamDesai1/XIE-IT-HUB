// ignore_for_file: prefer_const_constructors,use_build_context_synchronously

import 'package:college_manager/models/attendance.dart';
import 'package:college_manager/widgets/att_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('hive_db');
  Hive.registerAdapter(AttendanceAdapter());
  // Hive.openBox("attendance");
  runApp(ProviderScope(
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendancePage(),
    ),
  ));
}

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List subjects = ['AI & DS -II', 'IOE', 'STQA', 'MANET', 'ILOC'];
  late double percentage;
  late int attended;
  late int key;
  late Box<Attendance> attBox;
  double totalPercentage = 0;
  int att = 0;

  @override
  void initState() {
    super.initState();
    getAtt();
  }

  void calculate(int bunked, int total, String subject) async {
    setState(() {
      attended = total - bunked;
    });
    percentage =
        double.parse(((attended * 100) / total).toStringAsExponential(2));
    attBox = await Hive.openBox('attendance');
    try {
      attBox.add(
        Attendance(
            subj: subject,
            percentage: percentage,
            bunked: bunked,
            attended: attended,
            totalLecs: total),
      );
      debugPrint("Added S");
    } catch (e) {
      debugPrint("err");
    }
  }

  void updateAttendance(int bunked, int total, String subject) async {
    attBox = await Hive.openBox('attendance');
    Attendance? attendance;
    try {
      attendance = attBox.values.firstWhere((att) => att.subj == subject);
      key = attendance.key;
    } catch (e) {
      attendance = null;
    }

    if (attendance != null) {
      setState(() {
        attended = total - bunked;
      });
      percentage =
          double.parse(((attended * 100) / total).toStringAsExponential(2));
      attBox.putAt(
        key,
        Attendance(
            subj: subject,
            percentage: percentage,
            bunked: bunked,
            attended: attended,
            totalLecs: total),
      );
    } else {
      calculate(bunked, total, subject);
    }
  }

  void popoup(String subject) async {
    attBox = await Hive.openBox('attendance');
    Attendance? attendance;
    try {
      attendance = attBox.values.firstWhere((att) => att.subj == subject);
    } catch (e) {
      attendance = null;
    }

    final bunked = TextEditingController();
    final total = TextEditingController();

    if (attendance != null) {
      bunked.text = attendance.bunked.toString();
      total.text = attendance.totalLecs.toString();
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            height: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 242,
                      child: TextField(
                        controller: bunked,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Bunked Lectures",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          int newBunkedValue = int.parse(bunked.text) + 1;
                          bunked.text = newBunkedValue.toString();
                          int newtotalValue = int.parse(total.text) + 1;
                          total.text = newtotalValue.toString();
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                SizedBox(height: 10),
                TextField(
                  controller: total,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Total Lectures",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    updateAttendance(
                      int.parse(bunked.text),
                      int.parse(total.text),
                      subject,
                    );
                    getAtt();
                    // printBoxContents();
                    Navigator.pop(context);
                  },
                  child: Text("Marked"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void getAtt() async {
    attBox = await Hive.openBox('attendance');

    double percent = 0;

    for (final attendance in attBox.values) {
      percent += attendance.percentage;
      att++;
      debugPrint(attendance.percentage.toString());
    }
    debugPrint(percent.toString());
    debugPrint(att.toString());
    setState(() {
      totalPercentage = percent / att;
    });
    setState(() {
      att = 0;
    });
    debugPrint(totalPercentage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String subject = subjects[index];

                return FutureBuilder(
                  future: Hive.openBox<Attendance>('attendance'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var attBox = snapshot.data!;
                      var attendance = attBox.values.firstWhere(
                          (att) => att.subj == subject,
                          orElse: () => Attendance.zeroAttendance(subject));

                      return Column(
                        children: [
                          AttCard(
                            function: () => popoup(subject),
                            percentage: attendance.percentage,
                            subject: attendance.subj,
                            totalLecs: attendance.totalLecs,
                            attended: attendance.attended,
                            bunked: attendance.bunked,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator(); // Show a loading indicator while opening the box
                    }
                  },
                );
              },
              itemCount: subjects.length,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Attendance:",
                  style: GoogleFonts.acme(
                    fontSize: 24,
                  ),
                ),
                totalPercentage < 75
                    ? Text(
                        totalPercentage.toString(),
                        style:
                            GoogleFonts.acme(fontSize: 26, color: Colors.red),
                      )
                    : Text(
                        totalPercentage.toString(),
                        style:
                            GoogleFonts.acme(fontSize: 26, color: Colors.green),
                      )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
