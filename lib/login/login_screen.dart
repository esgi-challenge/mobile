import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:dio/dio.dart';
import 'package:mobile/login/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final dio = Dio();
  bool _isError = false;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  Future<void> login(BuildContext context, VoidCallback onSuccess) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var response = await dio.post('${globals.apiUrl}/api/auth/login',
          data: {'password': password.text, 'email': email.text});

      if (response.statusCode == 200) {
        await AuthService.saveJwt(response.data["token"]);
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
    } finally {
      setState(() {
        _isLoading = false;
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
                  Builder(builder: (context) {
                    if (_isError) {
                      return const Column(
                        children: [
                          Text(
                            "Votre email ou mot de passe n'est pas bon",
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
                          height: 32,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                GoRouter router = GoRouter.of(context);

                                router.push('/forgot-password');
                              },
                              child: Text(
                                "Mot de passe oublié?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextButton(
                          onPressed: !_isLoading
                              ? () => login(context, () {
                                    if (!mounted) {
                                      return;
                                    }

                                    GoRouter router = GoRouter.of(context);
                                    router.push('/');
                                  })
                              : null,
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
                                      0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _isLoading
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        )
                                      ],
                                    )
                                  : const Text(
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
