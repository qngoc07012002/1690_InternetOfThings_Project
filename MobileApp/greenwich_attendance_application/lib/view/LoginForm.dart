import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'MainScreen.dart';
import 'StudentList.dart';

void main() {
//  HttpOverrides.global = MyHttpOverrides();
  runApp(const LoginForm());
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginForm = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Container(
                          width: size.width * 0.55,
                          height: size.height * 0.35,
                          child: Image.asset('images/img.png'),
                        ),
                        const Text('GREENWICH ATTENDANCE', style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(46, 29, 91, 1),
                        ),),
                      ],
                    )

                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Form(
                  key: _loginForm,
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.8,
                        child: TextFormField(
                          decoration:  const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.email, color: Color.fromRGBO(46, 29, 91, 1),),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty){
                              return "Please enter username";
                            }
                            return null;
                          },
                          controller: _username,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        width: size.width * 0.8,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.key, color: Color.fromRGBO(46, 29, 91, 1)),
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          ],

                          validator: (value){
                            if (value == null || value.isEmpty){
                              return "Please enter password";
                            }
                            return null;
                          },
                          controller: _password,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SizedBox(
                        width: size.width * 0.8,
                        height: size.height * 0.06,
                        child:ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(46, 29, 91, 1)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(size.width * 0.02),
                                side: BorderSide(
                                  width: size.width * 0.8,
                                  color: const Color.fromRGBO(46, 29, 91, 1),
                                ),
                              ),
                            ),
                          ),
                          onPressed:() async {
                            if (_loginForm.currentState!.validate()){
                              if (_username.text == 'admin' && _password.text == 'admin') {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) {
                                      return const MainScreen();
                                    },
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }
                            }
                            // if (_signInForm.currentState!.validate()){
                            //   User user = User(
                            //     email: _email.text,
                            //     password: _password.text,);
                            //   context.read<UserCubit>().signIn(user);
                            //
                            // }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(

          onPressed: () {

          },
          backgroundColor: Color.fromRGBO(46, 29, 91, 1),
          child: const Icon(Icons.people),
        ),
      ),
    );
  }
}
