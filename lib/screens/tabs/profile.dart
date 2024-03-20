import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '/widgets/bottom_nav_bar.dart';


class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xC90000FF),
          title: const Center(
            child: Text(
              "Profile Page", 
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
        body: Column(
          children: [
            Container(
              height: 30.h,
              width: double.infinity,
              color: const Color(0xC90000FF),
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/images/dhruv.png",
                      scale: 0.35.w,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const Text(
                    "Dhruv Agrawal",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("XIE ID:"), Text("202003027")],
                ),
                SizedBox(
                  width: 7.w,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("XIE ID:"), Text("202003027")],
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Year:"), Text("Final Year")],
                ),
                SizedBox(
                  width: 7.w,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Batch:"), Text("2020-2024")],
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("D.O.B:"), Text("6/12/2002")],
                ),
                SizedBox(
                  width: 7.w,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Address:"), Text("Pune")],
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Email:"), Text("abc@xyz.com")],
                ),
                SizedBox(
                  width: 7.w,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Phone No:"), Text("9876543321")],
                ),
              ],
            ),

            // ElevatedButton(
            //     onPressed: () {
            //       ref.read(goRouterNotifierProvider).isLoggedIn == false;
            //       GoRouter.of(context).push('/login');
            //     },
            //     child: const Text("Log Out"))
          ],
        ),
      ),
    );
  }
}
