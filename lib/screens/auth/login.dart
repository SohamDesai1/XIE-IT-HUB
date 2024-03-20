// ignore_for_file: unnecessary_null_comparison

import 'package:college_manager/providers/firebase_auth.dart';
import 'package:college_manager/routes/go_router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

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
    final auth = ref.watch(authRepositoryProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                child: Image.asset("assets/images/log.png"),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Login to continue to app",
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: password,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Forgot Password?"),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: const Color.fromARGB(255, 2, 101, 255)),
                        child: TextButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   final user = auth.loginWithEmailAndPassword(
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
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 30,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Or Login with"),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      endIndent: 30,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      final user = auth.loginwithGoogle();
                      if (user != null) {
                        ref.read(goRouterNotifierProvider).isLoggedIn = true;
                        GoRouter.of(context).pushReplacement('/');
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/register');
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
