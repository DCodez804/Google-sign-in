import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/svg/logofolk.png',
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 3,
              fit: BoxFit.fitWidth,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
