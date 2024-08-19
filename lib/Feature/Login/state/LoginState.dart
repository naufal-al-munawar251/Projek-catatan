import 'package:flutter/cupertino.dart';

abstract class LoginState{
  final String email;
  final String password;
  LoginState(this.email, this.password);
}

abstract class LoginEventState{

}

class LoginEvent extends LoginEventState{
  final BuildContext context;
  LoginEvent(this.context);
}

class LoginInittial extends LoginState{
  LoginInittial() : super("","");
}

class Login extends LoginState{
  Login(String email,String password) : super(email,password);

}