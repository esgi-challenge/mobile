import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class InvitationRegisterScreen extends StatefulWidget {
  const InvitationRegisterScreen({super.key, required this.code});
  final String code;

  @override
  State<InvitationRegisterScreen> createState() =>
      _InvitationRegisterScreenState();
}

class _InvitationRegisterScreenState extends State<InvitationRegisterScreen> {
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

  Future<void> setPassword(BuildContext context, VoidCallback onSuccess) async {
    if (password.text != passwordConfirmation.text) {
      return;
    }

    try {
      var response = await dio.post(
          '${dotenv.env['API_URL']}/api/auth/invitation-code',
          data: {'password': password.text, 'invitationCode': widget.code});

      if (response.statusCode == 200) {
        onSuccess.call();
      } else {
        setState(() {
          _isError = true;
        });
      }
    } on DioException {
      setState(() {
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
                      "Bienvenu dans Studies",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Center(
                    child: Text(
                      "Entrez le mot de passe qui sera associe a votre email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
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
                            "Il y a eu une erreur lors de la creation de votre compte",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
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
                            hintText: "Entrer votre mot de passe",
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
                          height: 16,
                        ),
                        TextFormField(
                          controller: passwordConfirmation,
                          decoration: const InputDecoration(
                            hintText: "Confirmer votre mot de passe",
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
                          onPressed: () => setPassword(context, () {
                            if (!mounted) {
                              return;
                            }

                            GoRouter router = GoRouter.of(context);
                            router.push('/');
                          }),
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
                                "Creer votre compte",
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
