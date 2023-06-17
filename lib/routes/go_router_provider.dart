import 'package:college_manager/pages/attendance.dart';
import 'package:college_manager/pages/home_page.dart';
import 'package:college_manager/pages/login.dart';
import 'package:college_manager/pages/profile.dart';
import 'package:college_manager/pages/register.dart';
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
      GoRoute(
        path: '/home',
        name: "Home",
        builder: (context, state) => HomePage(key: state.pageKey),
      ),
      GoRoute(
        path: '/attendance',
        name: "Attendance",
        builder: (context, state) => Attendance(key: state.pageKey),
      ),
      GoRoute(
        path: '/profile',
        name: "Profile",
        builder: (context, state) => Profile(key: state.pageKey),
      ),
      GoRoute(
        path: '/login',
        name: "Login",
        builder: (context, state) => Login(key: state.pageKey),
      ),
      GoRoute(
        path: '/register',
        name: "Register",
        builder: (context, state) => Register(key: state.pageKey),
      ),
      ShellRoute(
        navigatorKey: _shell,
        builder: (context, state, child) => HomePage(key: state.pageKey),
        routes: [
          GoRoute(
            path: '/',
            name: "Root",
            redirect: (context, state) =>
                ref.read(goRouterNotifierProvider).isLoggedIn == true
                    ? '/'
                    : '/login',
            builder: (context, state) => HomePage(
              key: state.pageKey,
            ),
          )
        ],
      ),
    ],
  );
});
