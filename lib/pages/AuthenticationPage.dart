import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';

class AuthenticationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    emailController.clear();
    passwordController.clear();
    final favm = watch(firebaseAuth);
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
              width: 200,
              height: 50,
              color: Colors.grey,
              child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'E-mail',
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)))),
        ),
        Container(
            width: 200,
            height: 50,
            color: Colors.grey,
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)))),
        GestureDetector(
          onTap: () {
            print('email: |' +
                emailController.text +
                '| password: |' +
                passwordController.text +
                '|');
            favm.signIn(emailController.text, passwordController.text);
          },
          child: Container(
              width: 200,
              height: 50,
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Sign-in',
                  textAlign: TextAlign.center,
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            print('email: |' +
                emailController.text +
                '| password: |' +
                passwordController.text +
                '|');
            favm.register(emailController.text, passwordController.text);
          },
          child: Container(
              width: 200,
              height: 50,
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Register',
                  textAlign: TextAlign.center,
                ),
              )),
        ),
      ]),
    ));
  }
}
