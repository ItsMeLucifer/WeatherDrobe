import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';

class AuthenticationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Text(
                  "One account - Multiple devices",
                  style: TextStyle(
                    fontFamily: tools.fontFamily,
                    fontSize: 25,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.black,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  "One account - Multiple devices",
                  style: TextStyle(
                    fontFamily: tools.fontFamily,
                    fontSize: 25,
                    color: tools.textColor,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              color: tools.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 220,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // favm.exceptionMessage != ""
                        //     ? Text(
                        //         favm.exceptionMessage,
                        //         style: TextStyle(
                        //             fontFamily: tools.fontFamily,
                        //             color: Colors.red),
                        //         textAlign: TextAlign.center,
                        //       )
                        //     : Container(),
                        //SizedBox(height: 5),
                        Container(
                            width: 220,
                            height: 50,
                            child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                controller: tools.emailController,
                                onChanged: (value) {
                                  //favm.resetExceptionMessage();
                                },
                                style: TextStyle(
                                    color: tools.textColor,
                                    fontFamily: tools.fontFamily,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    hintText: 'E-mail',
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: tools.disabledText,
                                    ),
                                    focusColor: tools.textColor,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: disabledBorderColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: tools.textColor)),
                                    hintStyle: TextStyle(
                                        color: tools.disabledText,
                                        fontFamily: tools.fontFamily,
                                        fontWeight: FontWeight.bold),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10)))),
                        SizedBox(height: 5),
                        Container(
                            width: 220,
                            height: 50,
                            child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                autofocus: false,
                                obscureText: !tools.showPassword,
                                onChanged: (value) {
                                  //favm.resetExceptionMessage();
                                },
                                controller: tools.passwordController,
                                style: TextStyle(
                                    color: tools.textColor,
                                    fontFamily: tools.fontFamily,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: tools.disabledText,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        tools.showPassword =
                                            !tools.showPassword;
                                      },
                                      child: Icon(
                                          tools.showPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: tools.disabledText),
                                    ),
                                    hintStyle: TextStyle(
                                        color: tools.disabledText,
                                        fontFamily: tools.fontFamily,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: disabledBorderColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: tools.textColor)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10)))),
                        FlutterPasswordStrength(
                          password: tools.passwordController.text,
                          backgroundColor: tools.disabledText,
                        ),
                        SizedBox(height: 5),
                        tools.indicator
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(tools.textColor))
                            : Container(),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            tools.indicator = true;
                            favm.signIn(tools.emailController.text,
                                tools.passwordController.text);
                          },
                          child: Container(
                              width: 220,
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
                            tools.indicator = true;
                            favm.register(tools.emailController.text,
                                tools.passwordController.text);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              width: 220,
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
          ],
        ),
      ),
    ));
  }
}
