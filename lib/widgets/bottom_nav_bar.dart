import 'package:college_manager/providers/navigation.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
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
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/achievements');
        break;
      case 2:
        GoRouter.of(context).go('/notes');
        break;
      case 3:
        GoRouter.of(context).go('/profile');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedindex = ref.watch(navigationProvider);
    return FloatingNavbar(
      backgroundColor: Colors.white,
      unselectedItemColor: const Color.fromARGB(255, 0, 0, 128),
      selectedItemColor: Colors.blue,
      onTap: (int val) => _itemTapped(val),
      currentIndex: selectedindex,
      items: [
        FloatingNavbarItem(
          icon: Icons.home,
        ),
        FloatingNavbarItem(
          icon: Icons.emoji_events_outlined,
        ),
        FloatingNavbarItem(
          icon: Icons.file_copy_outlined,
        ),
        FloatingNavbarItem(
          icon: Icons.person_outline_outlined,
        ),
      ],
    );
  }
}
