import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../services/database.dart';

class Subjects extends ConsumerStatefulWidget {
  const Subjects({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubjectsState();
}

class _SubjectsState extends ConsumerState<Subjects> {
  @override
  Widget build(BuildContext context) {
    final hive = ref.watch(hiveDataProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xC90000FF),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: const Text(
                "Subjects",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: hive.when(
            data: (data) {
              final subjects = data.item1;
              final labNames = data.item2;
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, left: 22.w),
                      child: Row(
                        children: [
                          const Text(
                            "Thoery",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          const Text(
                            "Practical",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 65.w,
                      child: const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: SizedBox(
                            height: 75.h,
                            width: 25.w,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 43.w,
                                      height: 20.5.h,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          border:
                                              Border.all(color: Colors.black),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4.0,
                                              offset: Offset(3.0, 0),
                                            )
                                          ],
                                          color: Colors.white),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Image.asset(
                                              "assets/images/books.png",
                                              width: 17.w,
                                              height: 10.h,
                                            )),
                                            Text(subjects[index]),
                                            SizedBox(
                                              height: 2.85.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    )
                                  ],
                                );
                              },
                              itemCount: subjectNames.length,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: SizedBox(
                            height: 75.h,
                            width: 25.w,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      width: 43.w,
                                      height: 20.5.h,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          border:
                                              Border.all(color: Colors.black),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4.0,
                                              offset: Offset(3.0, 0),
                                            )
                                          ],
                                          color: Colors.white),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Image.asset(
                                              "assets/images/prac.png",
                                              width: 17.w,
                                              height: 10.h,
                                            )),
                                            Text(labNames[index]),
                                            SizedBox(
                                              height: 2.85.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    )
                                  ],
                                );
                              },
                              itemCount: labNames.length,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
