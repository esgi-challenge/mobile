import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heroicons/heroicons.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.code});
  final String code;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isSent = false;
  bool _isError = false;

  final dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    password.dispose();
    passwordConfirmation.dispose();
  }

  Future<void> sendResetLink() async {
    if (password.text != passwordConfirmation.text) {
      return;
    }

    try {
      var response = await dio.post(
          '${dotenv.env['API_URL']}/api/auth/reset-password',
          data: {'password': password.text, 'code': widget.code});

      if (response.statusCode == 204) {
        setState(() {
          _isSent = true;
          _isError = false;
        });
      } else {
        setState(() {
          _isSent = true;
          _isError = true;
        });
      }
    } on DioException {
      setState(() {
        _isSent = true;
        _isError = true;
      });
    }
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
                      "Entrez votre nouveau mot de passe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 128,
                  ),
                  Builder(builder: (context) {
                    if (password.text != passwordConfirmation.text) {
                      return const Column(
                        children: [
                          Text(
                            "Vos mot de passe ne correspondent pas",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }

                    if (_isError) {
                      return const Column(
                        children: [
                          Text(
                            "Il y a eu une erreur lors de la reinitialistion de votre mot de passe",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    } else if (_isSent) {
                      return const Column(
                        children: [
                          Text(
                            "Nous avons reinitialiser votre mot de passe",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      );
                    }

                    return Container();
                  }),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: password,
                          decoration: const InputDecoration(
                            hintText: "Enter votre nouveau password",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: HeroIcon(
                              HeroIcons.lockClosed,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          controller: passwordConfirmation,
                          decoration: const InputDecoration(
                            hintText: "Confirmez votre nouveau mot de passe",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: HeroIcon(
                              HeroIcons.lockClosed,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextButton(
                          onPressed: sendResetLink,
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
                                "Reinitialiser le mot de passe",
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
