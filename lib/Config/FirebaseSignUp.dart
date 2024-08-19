import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Feature/Home/pages/HomePages.dart';

class FirebaseSignUp{
  void SignUp(String ussername,String email, String password, BuildContext context)async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref.child(credential.user!.uid).child("Nama").set(ussername).then((a){
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message:
            "Akun anda berhasil dibuat",
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePages()),
              (Route<dynamic> route) => false, // Menghapus semua rute sebelumnya
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message:
            "Kata sandi yang diberikan terlalu lemah.",
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message:
            "Akun sudah ada untuk email itu.",
          ),
        );
      } else if (e.code == 'invalid-email') {
        print('Email tidak valid.');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message:
            "Email tidak valid.",
          ),
        );
      }else if (e.code == 'operation-not-allowed') {
        print('Operasi ini tidak diizinkan.');
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message:
            "Operasi ini tidak diizinkan.",
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}