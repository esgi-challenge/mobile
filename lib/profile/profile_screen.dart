import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/services/profile_service.dart';
import 'package:mobile/profile/bloc/profile_bloc.dart';
import 'package:mobile/shared/input_validator.dart';

import '../login/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordRepeatController = TextEditingController();

  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _updatePasswordFormKey = GlobalKey<FormState>();

  void _clearInputs() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _newPasswordRepeatController.clear();
  }

  Future<void> _logout(BuildContext context) async {
    await AuthService.logout();
    GoRouter.of(context).go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(ProfileService())..add(LoadProfile()),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(245, 242, 249, 1),
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProfileLoaded) {
                        return Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${state.profile['firstname']} ${state.profile['lastname']}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(72, 2, 151, 1),
                              ),
                            ),
                            Text(
                              '${state.profile['classRefer']}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(72, 2, 151, 1),
                              ),
                            ),
                            const SizedBox(height: 24),
                            _buildProfileForm(context, state.profile),
                            const SizedBox(height: 24),
                            _buildPasswordForm(context),
                          ],
                        );
                      } else if (state is ProfileNotFound) {
                        return const Center(child: Text('Profil non trouvé'));
                      } else if (state is ProfileError) {
                        return Center(child: Text('Erreur: ${state.errorMessage}'));
                      } else if (state is ProfilePasswordUpdated) {
                        _logout(context);
                        return const Center(child: Text('Profil'));
                      } else {
                        return const Center(child: Text('Profil'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context, dynamic profile) {
    _emailController.text = profile['email'];
    _phoneController.text = profile['phone'];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(50, 50, 50, 0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _updateFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(72, 2, 151, 1),
                  fontWeight: FontWeight.normal,
                ),
                border: UnderlineInputBorder(),
              ),
              style: const TextStyle(
                color: Color.fromRGBO(72, 2, 151, 1),
              ),
              validator: InputValidator.validateEmail,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
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
              validator: InputValidator.validatePhone,
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {
                if (_updateFormKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(UpdateProfile(
                    _emailController.text,
                    _phoneController.text,
                  ));
                }
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(249, 178, 53, 1),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
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
                    "Enregistrer les modifications",
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
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(50, 50, 50, 0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _updatePasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _oldPasswordController,
              decoration: const InputDecoration(
                hintText: 'Mot de passe actuel',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(72, 2, 151, 1),
                  fontWeight: FontWeight.normal,
                ),
                border: UnderlineInputBorder(),
              ),
              obscureText: true,
              validator: InputValidator.validatePassword,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                hintText: 'Nouveau mot de passe',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(72, 2, 151, 1),
                  fontWeight: FontWeight.normal,
                ),
                border: UnderlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value != _newPasswordController.text) {
                  return "Les mots de passe doivent correspondre";
                } else {
                  return InputValidator.validatePassword(value);
                }
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _newPasswordRepeatController,
              decoration: const InputDecoration(
                hintText: 'Confirmation du mot de passe',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(72, 2, 151, 1),
                  fontWeight: FontWeight.normal,
                ),
                border: UnderlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value != _newPasswordController.text) {
                  return "Les mots de passe doivent correspondre";
                } else {
                  return InputValidator.validatePassword(value);
                }
              },
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {
                if (_updatePasswordFormKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(UpdateProfilePassword(
                    _oldPasswordController.text,
                    _newPasswordController.text,
                  ));
                  _clearInputs();
                }
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(249, 141, 53, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
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
                    "Modifier le mot de passe",
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
    );
  }
}
