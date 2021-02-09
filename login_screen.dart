import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_sign_in/google_sign_in.dart';

//import 'package:http/http.dart' as http;
import '../widgets/login_button.dart';
import '../screens/homepage.dart';

class LoginScreen extends StatefulWidget {
  final bool isLoggedOut;
  final bool didErrorOccur;
  LoginScreen({this.isLoggedOut = false, this.didErrorOccur = false});
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (!widget.didErrorOccur) {
      if (!widget.isLoggedOut) {
        _googleSignIn.signInSilently().then(
          (user) {
            if (user != null) {
              Navigator.of(context).pushReplacementNamed(MyHomePage.routeName);
            }
          },
        ).catchError((error) {
          print(error);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _scaffold.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).errorColor,
                content: Text(
                  'An Error Occured',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          });
          return null;
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _scaffold.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                'Log out successful!!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        });
      }
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scaffold.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(
              'An Error Occured',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      });
    }
  }

  // Future<void> handleSignIn(BuildContext ctx) async {
  //   _currentUser = await _googleSignIn.signIn().catchError((error) {
  //     print('handling errors');
  //     _scaffold.currentState.showSnackBar(
  //       SnackBar(
  //         backgroundColor: Theme.of(ctx).errorColor,
  //         content: Text(
  //           'An Error Occured. Please Try Again.',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     );

  //     return null;
  //   });
  //   final googleAuth = await _currentUser.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // Future<bool> _handleSignOut() async {
  //   final state = await _googleSignIn.disconnect();
  //   FirebaseAuth.instance.signOut();
  //   if (state == null) {
  //     return true;
  //   }
  //   return false;
  // }

  //void _handleAppleSignIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/svg/logofolk.png',
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 3,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              'assets/svg/+.svg',
              height: MediaQuery.of(context).size.height / 3.2,
              width: MediaQuery.of(context).size.height / 3.2,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _isLoading == false
                ? MyLoginButton(
                    assetName: 'assets/svg/search.svg',
                    whichSignIn: 'Sign In with Google',
                  )
                : CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: MyLoginButton(
              assetName: 'assets/svg/apple.svg',
              whichSignIn: 'Sign In with Apple',
            ),
          ),
          SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }
}
