import 'package:college_manager/pages/attendance.dart';
import 'package:college_manager/pages/home_page.dart';
import 'package:college_manager/pages/auth/login.dart';
import 'package:college_manager/pages/profile.dart';
import 'package:college_manager/pages/auth/register2.dart';
import 'package:college_manager/routes/go_router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../pages/auth/register1.dart';

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
        builder: (context, state) => AttendancePage(key: state.pageKey),
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
          routes: [
            GoRoute(
                path: 'register2/:email:/name/:year/:id/:rollNo',
                name: "Register2",
                builder: (context, state) {
                  final email = state.pathParameters['email']!;
                  final name = state.pathParameters['name']!;
                  final year = state.pathParameters['year']!;
                  final id = state.pathParameters['id']!;
                  final rollNo = state.pathParameters['rollNo']!;
                  return Register2(
                    email,
                    name,
                    year,
                    int.parse(id),
                    int.parse(rollNo),
                    key: state.pageKey,
                  );
                }),
          ]),
      ShellRoute(
        navigatorKey: _shell,
        builder: (context, state, child) => HomePage(key: state.pageKey),
        routes: [
          GoRoute(
            path: '/',
            name: "Root",
            redirect: (context, state) =>
                ref.read(goRouterNotifierProvider).isLoggedIn == true
                    ? '/register'
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
