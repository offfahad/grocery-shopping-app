import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_shop_app/consts/firebase_const.dart';
import 'package:grocery_shop_app/fetch_screen.dart';
import 'package:grocery_shop_app/screens/btm_bar.dart';
import 'package:grocery_shop_app/services/global_methods.dart';
import 'package:grocery_shop_app/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await authInstance.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          if (authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(authResult.user!.uid)
                .set(
              {
                'id': authResult.user!.uid,
                'name': authResult.user!.displayName,
                'email': authResult.user!.email,
                'shipping-address': '',
                'userWish': [],
                'userCart': [],
                'createdAt': Timestamp.now(),
              },
            );
          }
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const FetchScreen(),
            ),
          );
        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(
              subtitle: '${error.message}', context: context);
        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);
        } finally {} 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Container(
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Container(
              //   color: Colors.white,
              //   child: Image.asset(
              //     'assets/images/google.png',
              //     width: 40.0,
              //   ),
              // ),
              const SizedBox(
                width: 8,
              ),
              TextWidget(
                  text: 'Continue with Google',
                  color: Colors.white,
                  textSize: 18)
            ]),
          ),
        ),
      ),
    );
  }
}
