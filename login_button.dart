import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:folk_developers/providers/google_sign_in.dart';

class MyLoginButton extends StatelessWidget {
  final String assetName;
  final String whichSignIn;

  MyLoginButton({
    this.assetName = ' ',
    this.whichSignIn = '',
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: OutlineButton(
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();
          },
          shape: StadiumBorder(),
          color: Colors.black,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                assetName,
                height: 40,
                width: 40,
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    whichSignIn,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
