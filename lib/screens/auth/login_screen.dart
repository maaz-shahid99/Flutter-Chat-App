import 'dart:developer';
import 'dart:io';

import 'package:chat_app/helper/dialogues.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../api/apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  late Size size; // Declare size variable

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true; // Trigger a rebuild when _isAnimate becomes true
      });
    });
  }

  _handleGoogleBtnClick(BuildContext context) { // Pass BuildContext parameter

    //For showing progressbar
    Dialogues.progressBar(context);

    //Signing in with google
    signInWithGoogle(context).then((user) {

      //For hiding progressbar
      Navigator.pop(context);

      if (user != null) {
        log("\nUser: ${user.user}");
        log("\ninfo: ${user.additionalUserInfo}");

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text('Welcome to We Chat'),
          ),
        ),
        body: Stack(
          children: [
            AnimatedPositioned(
              top: size.height * .15,
              right: _isAnimate ? size.width * .25 : -size.width * .25,
              width: size.width * .5,
              duration: const Duration(milliseconds: 1000),
              child: Image.asset('images/icons/chat.png'),
            ),
            Positioned(
              top: size.height * .5,
              height: size.height * .05,
              left: size.width * .05,
              width: size.width * .9,
              child: ElevatedButton.icon(
                onPressed: () {
                  _handleGoogleBtnClick(context); // Pass context here
                },
                icon: Image.asset(
                  'images/icons/google.png',
                  height: size.height * 0.04,
                ),
                label: const Text('Sign-in with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<UserCredential?> signInWithGoogle(BuildContext context) async { // Pass BuildContext parameter
  try {
    await InternetAddress.lookup("google.com");

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await APIs.auth.signInWithCredential(credential);
  } catch (e) {
    log('\n_signInWithGoogle $e');
    // ignore: use_build_context_synchronously
    Dialogues.showSnackbar(context, 'Something went Wrong. Check Internet!');
    return null;
  }
}
