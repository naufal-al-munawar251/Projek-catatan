import 'package:aplikasi_catatan/Config/FirebaseSignUp.dart';
import 'package:aplikasi_catatan/Feature/Home/pages/HomePages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../state/SignUpState.dart';

class LoginSignUpBloc extends Bloc<LoginSignUpEvent, LoginSignUpState> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmasipassword = TextEditingController();
  TextEditingController ussername = TextEditingController();
  final firebaseSignUp = FirebaseSignUp();

  LoginSignUpBloc() : super(LoginSignUpInittial()) {
    on<LoginSignUpEvent>((event, emit) {
      // Trim spaces from inputs
      String email = emailcontroller.text.trim();
      String password = passwordcontroller.text.trim();
      String confirmPassword = confirmasipassword.text.trim();
      String username = ussername.text.trim();

      // Validate inputs
      if (email.isEmpty) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Isi terlebih dahulu email tersebut",
          ),
        );
      } else if (username.isEmpty) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Isi terlebih dahulu username tersebut",
          ),
        );
      } else if (password.isEmpty) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Isi terlebih dahulu password tersebut",
          ),
        );
      } else if (confirmPassword.isEmpty) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Isi terlebih dahulu konfirmasi password tersebut",
          ),
        );
      } else if (!_isValidEmail(email)) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Email yang diberikan tidak valid.",
          ),
        );
      } else if (password.length < 6) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Password harus terdiri dari minimal 6 karakter.",
          ),
        );
      } else if (password != confirmPassword) {
        showTopSnackBar(
          Overlay.of(event.context),
          CustomSnackBar.error(
            message: "Password dan konfirmasi password tidak cocok.",
          ),
        );
      } else {
        // Proceed with signup
        firebaseSignUp.SignUp(username, email, password, event.context);
        emit(LoginSignUp(email, password, confirmPassword, username));
      }
    });
  }

  // Helper function to validate email format
  bool _isValidEmail(String email) {
    RegExp emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }
}
