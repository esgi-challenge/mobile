import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(72, 2, 151, 1),
                  Color.fromRGBO(51, 2, 108, 1),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Studies",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  const Image(image: AssetImage('assets/login.png')),
                  SizedBox(
                    height: 32,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: HeroIcon(
                              HeroIcons.atSymbol,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                              hintText: "Enter your password",
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon: HeroIcon(
                                HeroIcons.lockClosed,
                                color: Colors.white,
                              )),
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextButton(
                          onPressed: () {
                            GoRouter router = GoRouter.of(context);
                            print(email.text);
                            print(password.text);
                            router.go('/');
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(249, 178, 53, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(249, 178, 53, 0.1),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Se Connecter",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
