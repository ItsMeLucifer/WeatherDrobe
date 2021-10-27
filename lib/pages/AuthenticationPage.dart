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
    final tools = watch(toolsVM);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Card(
          color: tools.secondaryColor,
          child: Container(
            height: 210,
            width: 210,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                    width: 200,
                    height: 50,
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        controller: emailController,
                        style: TextStyle(
                            color: tools.textColor,
                            fontFamily: tools.fontFamily,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: 'E-mail',
                            focusColor: tools.textColor,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: tools.textColor)),
                            hintStyle: TextStyle(
                                color: tools.disabledText,
                                fontFamily: tools.fontFamily,
                                fontWeight: FontWeight.bold),
                            contentPadding:
                                EdgeInsets.fromLTRB(20, 10, 20, 10)))),
              ),
              Container(
                  width: 200,
                  height: 50,
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(
                          color: tools.textColor,
                          fontFamily: tools.fontFamily,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: tools.disabledText,
                              fontFamily: tools.fontFamily,
                              fontWeight: FontWeight.bold),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: tools.textColor)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20, 10, 20, 10)))),
              GestureDetector(
                onTap: () {
                  favm.signIn(emailController.text, passwordController.text);
                },
                child: Container(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Sign-in',
                        style: TextStyle(
                            color: tools.textColor,
                            fontFamily: tools.fontFamily,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  favm.register(emailController.text, passwordController.text);
                },
                child: Container(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: tools.textColor,
                            fontFamily: tools.fontFamily,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
