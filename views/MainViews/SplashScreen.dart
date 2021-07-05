import 'package:farrago/views/Authentication/Login.dart';
import 'package:farrago/views/Authentication/Register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height/7,),
            Container(height: 1.0,),//to get everything at middle

            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(3.0, 3.0),
                    blurRadius: 15.0,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-3.0, -3.0),
                      blurRadius: 15.0,
                      spreadRadius: 1,
                  ),
                ]
              ),
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(-3.0, -3.0),
                        blurRadius: 10.0,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(3.0, 3.0),
                          blurRadius: 10.0,
                          spreadRadius: 1
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(75)),
                  ),
                  child: Center(
                    child: Text("Farrago",style: TextStyle(color: Colors.blueAccent,fontSize: 22.0,fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: ()=> Get.to(()=> SignUp(),transition: Transition.zoom),
              child: Container(
                margin: EdgeInsets.only(top: 80.0),
                height: 50,
                width: Get.width*2/3,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(3.0, 3.0),
                        blurRadius: 15.0,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-3.0, -3.0),
                          blurRadius: 15.0,
                          spreadRadius: 2
                      ),
                    ]
                ),
                child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18),),),
              ),
            ),

            GestureDetector(
              onTap: ()=> Get.to(()=> Login(),transition: Transition.zoom),
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                height: 50,
                width: Get.width*2/3+50,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(3.0, 3.0),
                        blurRadius: 15.0,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-3.0, -3.0),
                          blurRadius: 15.0,
                          spreadRadius: 2
                      ),
                    ]
                ),
                child: Center(child: Text("Already a member? Login",style: TextStyle(color: Colors.blueAccent,fontSize: 15),),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
