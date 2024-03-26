import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../routes/go_router_notifier.dart';
import '../widgets/bottom_nav_bar.dart';
import '../screens/tabs/achievements.dart';
import '../screens/miscellaneous/attendance.dart';
import '../screens/miscellaneous/calendar.dart';
import '../screens/tabs/home_page.dart';
import '../screens/auth/login.dart';
import '../screens/tabs/notes.dart';
import '../screens/tabs/profile.dart';
import '../screens/auth/register1.dart';
import '../screens/auth/register2.dart';
import '../screens/miscellaneous/results.dart';
import '../screens/miscellaneous/subjects.dart';
import '../screens/miscellaneous/syllabus.dart';
import '../screens/miscellaneous/student_council.dart';

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
      ),
      GoRoute(
          path: '/register2/:email:/:name/:year/:id/:rollNo',
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
      GoRoute(
        path: '/attendance',
        name: "Attendance",
        parentNavigatorKey: _root,
        builder: (context, state) => AttendancePage(key: state.pageKey),
      ),
      GoRoute(
        path: '/calendar',
        name: "Calendar",
        parentNavigatorKey: _root,
        builder: (context, state) => Calendar(key: state.pageKey),
      ),
      GoRoute(
        path: '/syllabus',
        name: "Syllabus",
        parentNavigatorKey: _root,
        builder: (context, state) => Syllabus(key: state.pageKey),
      ),
      GoRoute(
        path: '/subjects',
        name: "Subjects",
        parentNavigatorKey: _root,
        builder: (context, state) => Subjects(key: state.pageKey),
      ),
      GoRoute(
        path: '/results',
        name: "Results",
        parentNavigatorKey: _root,
        builder: (context, state) => Results(key: state.pageKey),
      ),
      GoRoute(
        path: '/council',
        name: "Student Council",
        parentNavigatorKey: _root,
        builder: (context, state) => StudentCouncil(key: state.pageKey),
      ),
      ShellRoute(
        navigatorKey: _shell,
        builder: (context, state, child) => BottomNavBar(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: "Home",
            redirect: (context, state) =>
                ref.read(goRouterNotifierProvider).isLoggedIn == true
                    ? '/'
                    : '/login',
            parentNavigatorKey: _shell,
            builder: (context, state) => HomePage(
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: '/profile',
            name: "Profile",
            parentNavigatorKey: _shell,
            builder: (context, state) => Profile(key: state.pageKey),
          ),
          GoRoute(
            path: '/achievements',
            name: "Achievements",
            parentNavigatorKey: _shell,
            builder: (context, state) => Achievements(key: state.pageKey),
          ),
          GoRoute(
            path: '/notes',
            name: "Notes",
            parentNavigatorKey: _shell,
            builder: (context, state) => Notes(key: state.pageKey),
          ),
        ],
      ),
    ],
  );
});
