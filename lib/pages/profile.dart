import 'package:college_manager/routes/go_router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/bottom_nav_bar.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Column(
        children: [
          const Text("Profile Page"),
          ElevatedButton(
              onPressed: () {
                ref.read(goRouterNotifierProvider).isLoggedIn == false;
              },
              child: const Text("Log Out"))
        ],
      ),
    );
  }
}
