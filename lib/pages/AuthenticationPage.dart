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
    final Color buttonColor = Color.fromRGBO(255, 255, 255, 0.2);
    final Color disabledBorderColor = Color.fromRGBO(255, 255, 255, 0.5);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background2.png"),
            alignment: Alignment.topCenter,
            fit: BoxFit.none,
            scale: 5.4),
      ),
      child: Center(
        child: Card(
          color: tools.primaryColor,
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
                            prefixIcon: new Icon(
                              Icons.mail,
                              color: tools.disabledText,
                            ),
                            focusColor: tools.textColor,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: disabledBorderColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: tools.textColor)),
                            hintStyle: TextStyle(
                                color: tools.disabledText,
                                fontFamily: tools.fontFamily,
                                fontWeight: FontWeight.bold),
                            contentPadding:
                                EdgeInsets.fromLTRB(20, 10, 20, 10)))),
              ),
              SizedBox(height: 5),
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
                          prefixIcon: new Icon(
                            Icons.vpn_key,
                            color: tools.disabledText,
                          ),
                          hintStyle: TextStyle(
                              color: tools.disabledText,
                              fontFamily: tools.fontFamily,
                              fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: disabledBorderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: tools.textColor)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20, 10, 20, 10)))),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  favm.signIn(emailController.text, passwordController.text);
                },
                child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
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
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  favm.register(emailController.text, passwordController.text);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    width: 200,
                    height: 40,
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
