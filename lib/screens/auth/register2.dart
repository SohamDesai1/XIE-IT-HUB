import 'package:college_manager/apis/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/text_fields.dart';

// void main() {
//   runApp(Sizer(
//     builder: (context, orientation, deviceType) {
//       return const MaterialApp(
//         home: ProviderScope(child: Register2()),
//       );
//     },
//   ));
// }

class Register2 extends ConsumerStatefulWidget {
  final String email;
  final String name;
  final String year;
  final int id;
  final int rollNo;
  const Register2(this.email, this.name, this.year, this.id, this.rollNo,
      {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Register2State();
}

class _Register2State extends ConsumerState<Register2> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conpassword = TextEditingController();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF000080),
            )),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xFF000080),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.9.h,
                    ),
                    InputField(
                      pass: passwordVisible,
                      er1: "Password is required",
                      er2:
                          'Password must contain at least 1 uppercase letter,\n 1 digit, 1 symbol and minimum 6 characters',
                      reg: RegExp(
                          r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{6,})'),
                      inputType: TextInputType.visiblePassword,
                      controller: _password,
                      label: "Password",
                      sicon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2.9.h,
                    ),
                    InputField(
                        er1: "Password does not match",
                        inputType: TextInputType.visiblePassword,
                        controller: _conpassword,
                        label: "Confirm Password"),
                    SizedBox(
                      height: 2.9.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        final isValid = _key.currentState?.validate();
                        if (isValid != null && isValid) {
                          SignUp.signupWithEmail(widget.email, _password.text);
                          SignUp.saveStudent(widget.id, widget.name,
                              widget.email, widget.year, widget.rollNo);
                          GoRouter.of(context).push('/');
                        }
                      },
                      child: Container(
                        width: 90.w,
                        height: 6.h,
                        color: const Color(0xFF000080),
                        child: const Center(
                            child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
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
