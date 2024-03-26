import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import '/widgets/timeline.dart';
import '/widgets/tiles.dart';

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
    CarouselItem(image: const AssetImage('assets/images/car.jpeg')),
    CarouselItem(image: const AssetImage('assets/images/car.jpeg')),
    CarouselItem(image: const AssetImage('assets/images/car.jpeg')),
    CarouselItem(image: const AssetImage('assets/images/car.jpeg'))
  ];
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
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
              const Timeline(),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.2.h),
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
                padding: EdgeInsets.only(left: 2.2.h),
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
                        InkWell(
                          onTap: () => GoRouter.of(context).push('/council'),
                          child: Tile(
                              color: const Color(0xFFDFF978),
                              image: "assets/images/tiles/stud.png",
                              name: tiles[6]),
                        ),
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
