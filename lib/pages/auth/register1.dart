import 'dart:developer';

import 'package:college_manager/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(Sizer(
    builder: (context, orientation, deviceType) {
      return const MaterialApp(
        home: ProviderScope(child: Register()),
      );
    },
  ));
}

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _rollNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  String year = "Year";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/log.png",
              width: 100.w,
              height: 25.h,
            ),
            SizedBox(
              height: 3.3.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xFF000080),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Color(0xFF000080),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: DropdownButton(
                              value: year,
                              style: const TextStyle(color: Colors.white),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white, // <-- SEE HERE
                              ),
                              hint: const Text("Year",
                                  style: TextStyle(color: Colors.white)),
                              dropdownColor: const Color(0xFF000080),
                              items: <String>[
                                'Year',
                                'SE',
                                'TE',
                                'BE'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  year = value!;
                                });
                                log(year);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.7.h,
                    ),
                    InputField(
                        er1: "Name is required",
                        inputType: TextInputType.name,
                        controller: _name,
                        label: "Name"),
                    SizedBox(
                      height: 2.9.h,
                    ),
                    InputField(
                        er1: "Email is required",
                        er2: "Email is not valid",
                        reg: RegExp(
                            r"^[a-zA-Z0-9._%+-]+@student\.xavier\.ac\.in$"),
                        inputType: TextInputType.emailAddress,
                        controller: _email,
                        label: "Email"),
                    SizedBox(
                      height: 2.9.h,
                    ),
                    InputField(
                        er1: "XIE ID is required",
                        er2: "XIE ID is not valid",
                        reg: RegExp(r"^\d{1,9}$"),
                        inputType: TextInputType.number,
                        controller: _id,
                        label: "XIE ID"),
                    SizedBox(
                      height: 2.9.h,
                    ),
                    InputField(
                        er1: "er1",
                        er2: "er2",
                        inputType: TextInputType.number,
                        controller: _rollNo,
                        label: "Roll No"),
                    SizedBox(
                      height: 2.9.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!_key.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Error",
                                      style: TextStyle(color: Colors.red)),
                                  content: const Text(
                                      'Fill All the Required Fields'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        } else {
                          GoRouter.of(context).push('/register/register2');
                        }
                      },
                      child: Container(
                        width: 90.w,
                        height: 6.h,
                        color: const Color(0xFF000080),
                        child: const Center(
                            child: Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(
                            color: Color(0xFF797676),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF797676),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
