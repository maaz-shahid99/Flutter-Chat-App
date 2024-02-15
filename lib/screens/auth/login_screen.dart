import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true; // Trigger a rebuild when _isAnimate becomes true
      });
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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
