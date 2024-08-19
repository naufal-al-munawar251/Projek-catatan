import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../Home/pages/HomePages.dart';
import '../blocs/SignUpBlocs.dart';
import '../state/SignUpState.dart';


class LoginSignUpStatefull extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginSignUp();
}

class LoginSignUp extends State<LoginSignUpStatefull>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LoginSignUpBloc(),child: BlocBuilder<LoginSignUpBloc,LoginSignUpState>(builder: (context,state){
      return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Lottie.network('https://lottie.host/20c79414-01f5-447c-ad96-73d309af5932/E2yn2kSgSf.json',width: 300),

                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15),child: Text("Ussername",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),)
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 10, right: 10,top: 10, bottom: 10),child: TextField(controller: context.read<LoginSignUpBloc>().ussername, decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      hintText: "Ussername",
                      prefixIconColor: Colors.green,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 2
                          )
                      )
                  ),),),

                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15),child: Text("Email",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),)
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 10, right: 10,top: 10, bottom: 10),child: TextField(controller: context.read<LoginSignUpBloc>().emailcontroller, decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      prefixIconColor: Colors.green,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 2
                          )
                      )
                  ),),),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15),child: Text("Password",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),)
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 10),
                    child: TextField(controller: context.read<LoginSignUpBloc>().passwordcontroller,obscureText: true,decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Password",
                        prefixIconColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2
                          )
                        )
                    )),),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15),child: Text("Confirm Password",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),)
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 10),
                    child: TextField(controller: context.read<LoginSignUpBloc>().confirmasipassword,obscureText: true,decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: Colors.green,
                        hintText: "Confirm Password",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.green,
                                width: 2
                            )
                        )
                    )),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10,right: 10, bottom: 10),child: Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: InkWell(
                          onLongPress: (){

                          },
                          onTap: (){
                            context.read<LoginSignUpBloc>().add(LoginSignUpEvent(context));
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),)
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