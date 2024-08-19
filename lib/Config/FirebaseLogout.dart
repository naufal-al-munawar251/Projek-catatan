import 'package:aplikasi_catatan/Feature/Login/pages/LoginPages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FirebaseLogout{
  void Logout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null) {

      }
      else{
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message:
            "Anda berhasil logout",
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
        );

      }
    });
  }
}