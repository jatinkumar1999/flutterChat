import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/widget/auth/auth_Form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  void _submit(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) async {
    final _auth = FirebaseAuth.instance;
    UserCredential result;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(result.user!.uid)
            .set({
          "userName": userName,
          "email": email,
        });
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      var message = "An error occured , Please check your credentials";
      if (e.message != null) {
        message = e.code;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(message),
            ],
          )));
    } catch (e) {
      print("error is this :=>  $e");
      // setState(() {
      //   _isLoading = false;
      // });
      // ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).canvasColor,
              ]),
        ),
        child: AuthForm(_submit, _isLoading),
      ),
    );
  }
}
