import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthenticationState();
  }
}

class _AuthenticationState extends State<Authentication> {

  bool _signedIn = false;
  ValueNotifier userCredential = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authorization'),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_signedIn ? 'You are signed in' : 'You are not signed in'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async  {
                 signInWithGoogle();
              },
              icon:  Image.asset('assets/images/icons8-google-color/icons8-google-48.png'),
              label: const Text('Sign in with Google'),
            ),
          ],
        ),
      )
    );
  }



  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    setState(() {
      _signedIn = true;
    });
    return userCredential;
  }
}