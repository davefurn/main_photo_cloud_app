import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_bloc.dart';
import 'package:main_photo_cloud_app/lib/bloc/app_event.dart';
import 'package:main_photo_cloud_app/lib/extensions/if_debugging.dart';

class RegisterView extends HookWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'davidokoh2000@gmail.com'.ifDebugging,
    );

    final passwordController = useTextEditingController(
      text: 'foobarbaz'.ifDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Register',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email here....',
              ),
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your password here....',
              ),
              keyboardAppearance: Brightness.dark,
              obscureText: true,
              obscuringCharacter: '*',
            ),
            TextButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                context.read<Appbloc>().add(
                      AppEventRegister(
                        email: email,
                        password: password,
                      ),
                    );
              },
              child: const Text(
                'Register',
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<Appbloc>().add(
                      const AppEventGoToLogin(),
                    );
              },
              child: const Text(
                'Already registered, Log in here!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
