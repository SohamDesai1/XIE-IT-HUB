import 'package:college_manager/providers/navigation.dart';
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
    return BottomNavigationBar(
      onTap: _itemTapped,
      currentIndex: selectedindex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Attendance",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: "Profile",
        ),
      ],
    );
  }
}
