
import 'package:flutter/material.dart';

import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/utilities/show_error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
late final  TextEditingController _email;
  late final TextEditingController _password;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
     _email    = TextEditingController();
     _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),),
      body: Column(
               children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Email',
                  ),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password'
                  ),
                ),
                TextButton(
                  onPressed: () async {
          
          
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      
                    await AuthService.firebase().createUser(
                      email: email,
                      password: password,
                      );
                      AuthService.firebase().sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute); 
    
                    } on WeakPasswordAuthException {
                      await showErrorDialog(
                        context,
                         'password is weak');

                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialog(
                        context,
                         'email already in use');

                    } on InvalidEmailAuthException {
                      await showErrorDialog(
                        context,
                         'invalid email');

                    } on GenericAuthException {
                      await showErrorDialog(
                        context, 
                       'register error',
                        );
                    }
                    
                  },
                child : const Text('Register'),
                ),
                TextButton(onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },child: const Text('Already have an account? login here !'),)
              ],  
            ),
    );
  }
}