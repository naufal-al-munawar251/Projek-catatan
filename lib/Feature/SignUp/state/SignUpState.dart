import 'package:flutter/cupertino.dart';

abstract class LoginSignUpState{
  final String email;
  final String password;
  final String cofirmasipassword;
  final String ussername;
  LoginSignUpState(this.email, this.password, this.cofirmasipassword, this.ussername);
}

abstract class LoginSignUpEventState{

}

class LoginSignUpEvent extends LoginSignUpEventState{
  final BuildContext context;
  LoginSignUpEvent(this.context);
}

class LoginSignUpInittial extends LoginSignUpState{
  LoginSignUpInittial() : super("","","","");
}

class LoginSignUp extends LoginSignUpState{
  LoginSignUp(String email,String password, String confirmpassword, String ussername) : super(email,password,confirmpassword, ussername);

}