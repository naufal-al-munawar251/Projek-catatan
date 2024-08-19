import 'package:aplikasi_catatan/Config/FirebaseSigIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../Home/pages/HomePages.dart';
import '../state/LoginState.dart';

class LoginBloc extends Bloc<LoginEventState, LoginState> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final firebaseSigin = FirebaseSigIn();

  LoginBloc(BuildContext context) : super(LoginInittial()) {
    on<LoginEvent>((event, emit) {
      // Trim spaces from email and password
      String email = emailcontroller.text.trim();
      String password = passwordcontroller.text.trim();

      // Validate email and password
      if (email.isEmpty) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Isi terlebih dahulu email tersebut",
          ),
        );
      } else if (password.isEmpty) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Isi terlebih dahulu password tersebut",
          ),
        );
      } else if (!_isValidEmail(email)) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Email yang diberikan tidak valid.",
          ),
        );
      } else {
        // Proceed with login
        firebaseSigin.SigIn(email, password, event.context);
        emit(Login(email, password));
      }
    });

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePages()),
              (Route<dynamic> route) => false, // Remove all previous routes
        );
      }
    });
  }

  // Helper function to validate email format
  bool _isValidEmail(String email) {
    RegExp emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }
}
