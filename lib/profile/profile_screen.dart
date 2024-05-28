import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final AddressComplementController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    AddressComplementController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 242, 249, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 58),
                      const Text(
                        'John DOE',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      const Text(
                        'IW3',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          hintText: 'Rue',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(72, 2, 151, 1),
                            fontWeight: FontWeight.normal,
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: AddressComplementController,
                        decoration: const InputDecoration(
                          hintText: 'Complément',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(72, 2, 151, 1),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Color.fromRGBO(72, 2, 151, 1),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: postalCodeController,
                              decoration: const InputDecoration(
                                hintText: 'Code postal',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(72, 2, 151, 1),
                                ),
                                border: UnderlineInputBorder(),
                              ),
                              style: const TextStyle(
                                color: Color.fromRGBO(72, 2, 151, 1),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: cityController,
                              decoration: const InputDecoration(
                                hintText: 'Ville',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(72, 2, 151, 1),
                                  fontWeight: FontWeight.normal,
                                ),
                                border: UnderlineInputBorder(),
                              ),
                              style: const TextStyle(
                                color: Color.fromRGBO(72, 2, 151, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'email',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(72, 2, 151, 1),
                            fontWeight: FontWeight.normal,
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Téléphone',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(72, 2, 151, 1),
                            fontWeight: FontWeight.normal,
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () {
                          GoRouter router = GoRouter.of(context);
                          router.go('/profile');
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
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Enregistrer",
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
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          GoRouter router = GoRouter.of(context);
                          router.go('/profile');
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(225, 124, 6, 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(249, 178, 53, 0.1),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Modifier mon mot de passe",
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
    );
  }
}
