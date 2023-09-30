import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_page_firebase/components/buttons.dart';
import 'package:login_page_firebase/components/text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  // sign user up method

  // Future signUp() async {
  //   if (passwordConfirmed()) {
  //     //Create user
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text, password: _passwordController.text);

  //     // add user details
  //     addUserData(
  //         _firstNameController.text.trim(),
  //         _lastNameController.text,
  //         _emailController.text,
  //         int.parse(_ageController.text),
  //         _passwordController.text);
  //   }
  // }

  // Future addUserData(String firstName, String lastName, String email, int age,
  //     String password) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'First Name': firstName,
  //     'Last Name': lastName,
  //     'Email': email,
  //     'Age': age,
  //     'Password': password
  //   });
  // }

  // bool passwordConfirmed() {
  //   if (_passwordController.text == _confirmPasswordController.text) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      //createing a new account
      if (_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        addUSerDetails(
            _firstNameController.text,
            _lastNameController.text,
            _emailController.text.toString(),
            _passwordController.text.toString(),
            int.parse(_ageController.text.toString()));

        //Data collection
      } else {
        //password dont match
        showErrorMessage("Password don't match");
      }

      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // Show Error Message
      showErrorMessage(e.code);
    }
  }

  Future addUSerDetails(String firstName, String lastName, String email,
      String password, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'First Name': firstName,
      'Last Name': lastName,
      'Age Name': age,
      'Email': email,
      'Password': password
    });
  }

  // wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 40),

                // welcome back, you've been missed!
                Text(
                  'Lets create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                MyTextField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                MyTextField(
                  controller: _ageController,
                  hintText: 'Age',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // email textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: _confirmPasswordController,
                  hintText: 'ConfirmPassword',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(
                    color: Colors.black38,
                  ),
                ),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
