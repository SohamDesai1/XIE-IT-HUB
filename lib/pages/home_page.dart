import 'package:college_manager/widgets/bottom_nav_bar.dart';
import 'package:college_manager/widgets/tiles.dart';
import 'package:go_router/go_router.dart';
import '../widgets/tt_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../utils/timeTable.dart';

void main() {
  runApp(
    ProviderScope(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const MaterialApp(
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    ),
  );
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<CarouselItem> items = [
    CarouselItem(image: const AssetImage('assets/images/log.png')),
    CarouselItem(image: const AssetImage('assets/images/log.png')),
    CarouselItem(image: const AssetImage('assets/images/log.png')),
    CarouselItem(image: const AssetImage('assets/images/log.png'))
  ];
  List<String> tt = [
    "Holiday",
    "Holiday",
    "Holiday",
    "Holiday",
    "Holiday",
    "Holiday",
    "Holiday",
  ];
  late List<Map<String, dynamic>> lectures;
  List<String> tiles = [
    "Calendar",
    "Subjects",
    "Syllabus",
    "Assignments",
    "Placements",
    "Results",
    "Student Committee",
    "TPO Activities"
  ];
  @override
  void initState() {
    setLectures();
    super.initState();
  }

  void getLectures() {
    int currentDay = DateTime.now().weekday;
    switch (currentDay) {
      case DateTime.monday:
        tt = monday;
        break;
      case DateTime.tuesday:
        tt = tuesday;
        break;
      case DateTime.wednesday:
        tt = wednesday;
        break;
      case DateTime.thursday:
        tt = thursday;
        break;
      case DateTime.friday:
        tt = friday;
        break;
      default:
        return;
    }
  }

  void setLectures() {
    getLectures();
    lectures = [
      {'name': tt[0], 'start': "8:45AM", 'end': "9:45AM"},
      {'name': tt[1], 'start': "9:45AM", 'end': "10:45AM"},
      {'name': 'Short Break', 'start': "10:45AM", 'end': "11:00AM"},
      {'name': tt[2], 'start': "11:00AM", 'end': "12:00PM"},
      {'name': tt[3], 'start': "12:00PM", 'end': "1:00PM"},
      {'name': 'Break', 'start': "1:00PM", 'end': "1:30PM"},
      {'name': tt[4], 'start': "1:30PM", 'end': "2:30PM"},
      {'name': tt[5], 'start': "2:30PM", 'end': "3:30PM"},
      {'name': tt[6], 'start': "3:30PM", 'end': "4:30PM"},
    ];
  }

  String determineStatus(int index, List<Map<String, dynamic>> lectures) {
    DateTime now = DateTime.now();

    DateTime startTime = DateTime(now.year, now.month, now.day).add(
        DateFormat("h:mma")
            .parse(lectures[index]['start'])
            .difference(DateTime(1970)));
    DateTime endTime = DateTime(now.year, now.month, now.day).add(
        DateFormat("h:mma")
            .parse(lectures[index]['end'])
            .difference(DateTime(1970)));

    // Check if the lecture is ongoing
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return "ongoing";
    }

    if (now.isAfter(endTime)) {
      return "done";
    }

    if (index > 0) {
      DateTime prevEndTime = DateTime(now.year, now.month, now.day).add(
          DateFormat("h:mma")
              .parse(lectures[index - 1]['end'])
              .difference(DateTime(1970)));
      if (now.isAfter(prevEndTime) && now.isBefore(startTime)) {
        return "next lecture";
      }
    }

    return "upcoming";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: const Text("Dashboard"),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Image.asset(
                "assets/images/xie.png",
                width: 10.w,
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomCarouselSlider(
                  items: items,
                  height: 28.h,
                  width: MediaQuery.of(context).size.width / 1.1,
                  autoplay: true,
                  showText: false,
                  showSubBackground: false,
                  indicatorShape: BoxShape.circle,
                  indicatorPosition: IndicatorPosition.bottom,
                  selectedDotColor: const Color(0xFF000080),
                  unselectedDotColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today’s Timeline',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${DateFormat.E().format(DateTime.now())}, ${DateFormat.yMMMd().format(DateTime.now())}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 8.h,
                      child: DateTime.now().weekday == 6 ||
                              DateTime.now().weekday == 7
                          ? const Center(child: Text("No Lectures Today!!"))
                          : ListView.builder(
                              itemCount: 9,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                String status =
                                    determineStatus(index, lectures);
                                return Row(
                                  children: [
                                    TTCard(
                                        classRoom: "LH-5",
                                        subject: lectures[index]["name"],
                                        time:
                                            "${lectures[index]["start"]}-${lectures[index]["end"]}",
                                        status: status),
                                    SizedBox(
                                      width: 3.5.w,
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => GoRouter.of(context).push('/calendar'),
                          child: Tile(
                              color: const Color(0xFFE82D92),
                              image: "assets/images/tiles/cal.png",
                              name: tiles[0]),
                        ),
                        SizedBox(
                          width: 4.5.w,
                        ),
                        GestureDetector(
                          onTap: () => GoRouter.of(context).push('/subjects'),
                          child: Tile(
                              color: const Color(0xFFFF5454),
                              image: "assets/images/tiles/sub.png",
                              name: tiles[1]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => GoRouter.of(context).push('/syllabus'),
                          child: Tile(
                              color: const Color(0xFFFEBBF3),
                              image: "assets/images/tiles/syl.png",
                              name: tiles[2]),
                        ),
                        SizedBox(
                          width: 4.5.w,
                        ),
                        Tile(
                            color: const Color(0xFF85D3FF),
                            image: "assets/images/tiles/ass.png",
                            name: tiles[3])
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Tile(
                            color: const Color(0xFFAA81EE),
                            image: "assets/images/tiles/place.png",
                            name: tiles[4]),
                        SizedBox(
                          width: 4.5.w,
                        ),
                        InkWell(
                          onTap: () => GoRouter.of(context).push('/results'),
                          child: Tile(
                              color: const Color(0xFFFEBBC7),
                              image: "assets/images/tiles/res.png",
                              name: tiles[5]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Tile(
                            color: const Color(0xFFDFF978),
                            image: "assets/images/tiles/stud.png",
                            name: tiles[6]),
                        SizedBox(
                          width: 4.5.w,
                        ),
                        Tile(
                            color: const Color(0xFFF8DAB5),
                            image: "assets/images/tiles/stud.png",
                            name: tiles[7])
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
