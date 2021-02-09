import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:folk_developers/providers/google_sign_in.dart';
import 'package:folk_developers/screens/splash_screen.dart';
import 'package:folk_developers/widgets/signed_up_widget.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import '../widgets/my_drawer.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/my-homepage';
  final Future<bool> Function() signOut;
  final GoogleSignInAccount user;
  MyHomePage({Key key, this.title = 'My Home Page', this.signOut, this.user})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, dataSnapshot) {
          final provider = Provider.of<GoogleSignInProvider>(ctx);
          if (provider.isSigningIn) {
            return SplashScreen();
          } else if (dataSnapshot.hasData) {
            return SignedUpWidget();
          } else {
            if (provider.isError) {
              print(provider.isError);
              return LoginScreen(
                didErrorOccur: provider.isError,
              );
            }
            print(provider.isError);
            print('Logout ${provider.isLoggedOut}');
            return LoginScreen(
              isLoggedOut: provider.isLoggedOut,
              didErrorOccur: provider.isError,
            );
          }
        },
      ),
    );
  }
}
