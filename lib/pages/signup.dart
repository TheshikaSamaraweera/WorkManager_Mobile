import 'package:flutter/material.dart';
import 'package:workapp/pages/login.dart';

import '../widget/widget_support.dart';

class SignUp extends StatefulWidget{
  const SignUp ({super.key});
  @override
  State<SignUp> createState() => _SignUpState();

}
class _SignUpState extends State<SignUp>{
  int currentTabIndex=0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFff5c30),
                        Color(0xFFe74b1a),
                      ])),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                  ) ),
              child: Text(""),

            ),
            Container(
              margin: EdgeInsets.only(top: 60.0,left: 20.0,right: 20.0),

              child: Column(children: [
                Center(child: Image.asset("images/png",
                  width: MediaQuery.of(context).size.width / 1.5,
                  fit: BoxFit.cover,
                )),
                SizedBox(height: 40.0,),
                Material(   //login box 1
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      SizedBox(height: 30.0,),
                      Text(
                        "Sign up", style: AppWidget.boldTextFieldstyle(),),
                      SizedBox(height: 20.0,),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: AppWidget.SemiboldTextFieldstyle(),
                            prefixIcon: Icon(Icons.person_2_outlined)),
                      ),
                      SizedBox(height: 20.0,),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Registration Number',
                            hintStyle: AppWidget.SemiboldTextFieldstyle(),
                            prefixIcon: Icon(Icons.numbers_outlined)),
                      ),
                      SizedBox(height: 20.0,),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: AppWidget.SemiboldTextFieldstyle(),
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      SizedBox(height: 20.0,),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: AppWidget.SemiboldTextFieldstyle(),
                            prefixIcon: Icon(Icons.password_outlined)),
                      ),

                      SizedBox(height: 40.0,),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical:8.0),
                          width: 200,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Color(0Xffff5722),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text("SIGN UP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Poppins1',
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()));
                          },
                          child: Text("Already have an account? Login",style:AppWidget.SemiboldTextFieldstyle() ,))



                    ],),
                  ),
                )
              ],
              ),
            )
          ],
        ),
      ),
    );;
  }
}