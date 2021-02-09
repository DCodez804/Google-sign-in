import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../providers/google_sign_in.dart';
import '../widgets/my_drawer.dart';

class SignedUpWidget extends StatefulWidget {
  @override
  _SignedUpWidgetState createState() => _SignedUpWidgetState();
}

class _SignedUpWidgetState extends State<SignedUpWidget> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scaffold.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(
              'Log in Successful!!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      });
    }
  }

  Widget _buildMyCard(String label, String data, double width) {
    return SizedBox(
      width: width,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Spacer(),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Text(
                data,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Spacer()
            ],
          ),
        ),
        elevation: 5.0,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              9.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _deviceInfo = MediaQuery.of(context);
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('My Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Spacer(),
              CircleAvatar(
                backgroundImage: NetworkImage(currentUser.photoURL),
              ),
              SizedBox(
                height: _deviceInfo.size.height / 10,
              ),
              _buildMyCard(
                'Name',
                currentUser.displayName,
                _deviceInfo.size.width / 1.2,
              ),
              SizedBox(
                height: _deviceInfo.size.height / 10,
                width: _deviceInfo.size.width / 2,
              ),
              _buildMyCard(
                  'E-mail', currentUser.email, _deviceInfo.size.width / 1.05),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
