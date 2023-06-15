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
  late TextEditingController email;
  late TextEditingController password;
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepositoryProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: password,
                decoration: const InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = auth.loginWithEmailAndPassword(
                          email.text, password.text);
                      if (user != null) {
                        ref.read(goRouterNotifierProvider).isLoggedIn = true;
                        ref.read(goRouterProvider).go('/');
                      }
                    }
                  },
                  child: const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
