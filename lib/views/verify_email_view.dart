
import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Verify email'),),
      body: Column(children: [
        const Text('We have sent you and email verification.'),
        TextButton(onPressed: () async {
          await AuthService.firebase().sendEmailVerification();
         },child: const Text("resend email verification"),
        ),
        TextButton (
         onPressed: () async {
           await AuthService.firebase().logOut();
           Navigator.of(context).pushNamedAndRemoveUntil(
            registerRoute,
             (route) => false); 
        },
         child: const Text('restart'),
        ),
       ],
      ),
    );
  }
}