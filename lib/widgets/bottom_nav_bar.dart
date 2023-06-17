import 'package:college_manager/providers/navigation.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  void _itemTapped(int index) {
    ref.read(navigationProvider.notifier).setIndex(index);
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/attendance');
        break;
      case 2:
        context.go('/profile');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedindex = ref.watch(navigationProvider);
    return CircleNavBar(
      activeIndex: selectedindex,
      activeIcons: const [
        Icon(Icons.home_filled),
        Icon(Icons.calendar_today),
        Icon(Icons.person_outlined),
      ],
      inactiveIcons: const [
        Text(
          "Home",
          style: TextStyle(
              fontFamily: "Sans-Serif",
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        Text(
          "Attendance",
          style: TextStyle(
              fontFamily: "Sans-Serif",
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        Text(
          "Profile",
          style: TextStyle(
              fontFamily: "Sans-Serif",
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        // Icon(Ionicons.calendar_clear)
      ],
      height: 60,
      circleWidth: 60,
      color: Colors.blueAccent,
      onTap: (index) => _itemTapped(index),
      shadowColor: Colors.deepPurple,
      circleShadowColor: Colors.deepPurple,
      elevation: 5,
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(255, 0, 147, 233),
          Color.fromARGB(255, 128, 208, 199)
        ],
      ),
      tabCurve: Curves.bounceInOut,
    );
  }
}
