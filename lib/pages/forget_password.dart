import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_firebase/components/buttons.dart';
import 'package:login_page_firebase/components/text_fields.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.toString());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: Colors.blue,
            content: const Text('Password reset link sent successfully',
                style: TextStyle(color: Colors.white)),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: Colors.blue,
            content: Text(e.message.toString(),
                style: const TextStyle(color: Colors.white)),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Forget Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('We will send you an Email!')),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),
          const SizedBox(
            height: 15,
          ),
          MyButton(onTap: passwordReset, text: 'Reset Password'),
        ],
      ),
    );
  }
}
