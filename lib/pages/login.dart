// ignore_for_file: unnecessary_null_comparison

import 'package:college_manager/providers/firebase_auth.dart';
import 'package:college_manager/routes/go_router_notifier.dart';
import 'package:college_manager/routes/go_router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepositoryProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Image.asset("assets/images/student.png"),
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
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final user = auth.loginWithEmailAndPassword(
                                    email.text, password.text);
                                if (user != null) {
                                  ref
                                      .read(goRouterNotifierProvider)
                                      .isLoggedIn = true;
                                  ref.read(goRouterProvider).go('/');
                                }
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 16),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
