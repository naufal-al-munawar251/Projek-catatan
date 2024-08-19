import 'package:aplikasi_catatan/Feature/Home/pages/HomePages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../SignUp/pages/SignUpPages.dart';
import '../blocs/LoginBlocs.dart';
import '../state/LoginState.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Login();

}

class Login extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LoginBloc(context),child: BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Lottie.network('https://lottie.host/20c79414-01f5-447c-ad96-73d309af5932/E2yn2kSgSf.json',width: 300),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15),child: Text("Email",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),)
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 10, right: 10,top: 10, bottom: 10),child: TextField(controller: context.read<LoginBloc>().emailcontroller, decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    prefixIconColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                ),),),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 15),child: Text("Password",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),)
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 10),
                  child: TextField(controller: context.read<LoginBloc>().passwordcontroller,obscureText: true,decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor: Colors.green,
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green,width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                  )),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(padding: EdgeInsets.only(left: 10,right: 10),
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        color: Colors.green,
                        child: InkWell(
                          radius: 30,
                          onTap: (){
                            context.read<LoginBloc>().add(LoginEvent(context));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50,
                            child: Text("Login",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )
                    ),),
                    Padding(padding: EdgeInsets.only(left: 10,right: 10),
                      child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              width: 2,
                              color: Colors.green
                            )
                          ),
                          color: Colors.white,
                          child: InkWell(
                            radius: 30,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSignUpStatefull()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 50,
                              child: Text("SignUp",style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                            ),
                          )
                      ),),
                  ],
                )
              ],
            ),
          ),
        )
      );
    }),);
  }

}