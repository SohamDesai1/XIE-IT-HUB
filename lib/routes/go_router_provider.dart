import '../screens/tabs/achievements.dart';
import '../screens/attendance.dart';
import '../screens/calendar.dart';
import '../screens/tabs/home_page.dart';
import '../screens/auth/login.dart';
import '../screens/tabs/notes.dart';
import '../screens/tabs/profile.dart';
import '../screens/auth/register1.dart';
import '../screens/auth/register2.dart';
import '../screens/results.dart';
import '../screens/subjects.dart';
import '../screens/syllabus.dart';
import '../routes/go_router_notifier.dart';
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
        path: '/achievements',
        name: "Achievements",
        builder: (context, state) => Achievements(key: state.pageKey),
      ),
      GoRoute(
        path: '/notes',
        name: "Notes",
        builder: (context, state) => Notes(key: state.pageKey),
      ),
      GoRoute(
        path: '/calendar',
        name: "Calendar",
        builder: (context, state) => Calendar(key: state.pageKey),
      ),
      GoRoute(
        path: '/syllabus',
        name: "Syllabus",
        builder: (context, state) => Syllabus(key: state.pageKey),
      ),
      GoRoute(
        path: '/subjects',
        name: "Subjects",
        builder: (context, state) => Subjects(key: state.pageKey),
      ),
      GoRoute(
        path: '/results',
        name: "Results",
        builder: (context, state) => Results(key: state.pageKey),
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
