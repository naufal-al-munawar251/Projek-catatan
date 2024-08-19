import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Feature/Home/pages/HomePages.dart';

class FirebaseSigIn{
  void SigIn(String email, String passowrd,BuildContext event)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: passowrd
      );
      Navigator.pushAndRemoveUntil(
        event,
        MaterialPageRoute(builder: (context) => HomePages()),
            (Route<dynamic> route) => false, // Menghapus semua rute sebelumnya
      );
      showTopSnackBar(
        Overlay.of(event),
        CustomSnackBar.success(
          message:
          "Login Anda Berhasil",
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showTopSnackBar(
          Overlay.of(event),
          CustomSnackBar.error(
            message:
            "Tidak ada pengguna yang ditemukan untuk email itu",
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showTopSnackBar(
          Overlay.of(event),
          CustomSnackBar.error(
            message:
            "Kata sandi salah diberikan untuk pengguna itu",
          ),
        );
      }
      else if (e.code == 'invalid-email') {
        print('Email tidak valid.');
        showTopSnackBar(
          Overlay.of(event),
          CustomSnackBar.error(
            message:
            "Email tidak valid",
          ),
        );
      }
      else if (e.code == 'network-request-failed') {
        print('Masalah jaringan atau koneksi.');
        showTopSnackBar(
          Overlay.of(event),
          CustomSnackBar.error(
            message:
            "Network or connection problems",
          ),
        );
      }
    }
  }
}