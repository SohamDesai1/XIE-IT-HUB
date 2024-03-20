// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:college_manager/routes/go_router_notifier.dart';
import 'package:college_manager/services/auth/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(loginProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Column(
            children: [
              SizedBox(
                width: 35.w,
                child: Image.asset("assets/images/log.png"),
              ),
              SizedBox(
                height: 8.w,
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 7.w, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Login to continue to app",
                style: TextStyle(fontSize: 4.w, color: Colors.grey[500]),
              ),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 2.4.h),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      SizedBox(
                        width: 85.w,
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(fontSize: 2.4.h),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      SizedBox(
                        width: 85.w,
                        child: TextFormField(
                          controller: password,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                            suffixIcon: IconButton(
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
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      SizedBox(
                        height: 2.2.h,
                      ),
                      const Text("Forgot Password?"),
                      SizedBox(
                        height: 2.2.h,
                      ),
                      Container(
                        width: 85.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.h),
                            color: const Color.fromARGB(255, 2, 101, 255)),
                        child: TextButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            // final user = auth.signInWithEmail(
                            //       email.text, password.text);
                            //   if (user != null) {
                            // ref.read(goRouterNotifierProvider).isLoggedIn =
                            //     true;
                            GoRouter.of(context).go('/home');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const HomePage(),
                            //     ));
                            // }
                            // }
                          },
                          child: Text(
                            "Login",
                            style:
                                TextStyle(fontSize: 2.h, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 3.h,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  const Text("Or Login with"),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      endIndent: 3.h,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 1.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      final user = auth.signInWithGoogle();
                      if (user != null) {
                        ref.read(goRouterNotifierProvider).isLoggedIn = true;
                        GoRouter.of(context).pushReplacement('/');
                      }
                    },
                    child: Container(
                      width: 16.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        border: Border.all(width: 0.3),
                        color: Colors.grey[200],
                      ),
                      child: const Center(
                        child: Icon(Ionicons.logo_google),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.7.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/register');
                    },
                    child: const Text(
                      " Register",
                      style: TextStyle(color: Color.fromARGB(255, 2, 101, 255)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
