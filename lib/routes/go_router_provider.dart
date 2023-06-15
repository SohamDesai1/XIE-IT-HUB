import 'package:college_manager/pages/attendance.dart';
import 'package:college_manager/pages/home.dart';
import 'package:college_manager/pages/home_page.dart';
import 'package:college_manager/pages/profile.dart';
import 'package:college_manager/routes/go_router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _root = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shell = GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    navigatorKey: _root,
    refreshListenable: notifier,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shell,
        builder: (context, state, child) => const Home(),
      ),
      GoRoute(
        path: '/',
        name: "Home",
        redirect: (context, state) =>
            ref.read(goRouterNotifierProvider).isLoggedIn == true
                ? '/home'
                : '/login',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/attendance',
        name: "Attendance",
        builder: (context, state) => const Attendance(),
      ),
      GoRoute(
        path: '/profile',
        name: "Profile",
        builder: (context, state) => const Profile(),
      ),
    ],
  );
});
