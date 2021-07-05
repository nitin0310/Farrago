import 'package:farrago/controllers/Authentication/AuthController.dart';
import 'package:farrago/models/User/UserModel.dart';
import 'package:farrago/views/MainViews/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthController userController = Get.put(AuthController());
  final formKey=GlobalKey<FormState>();
  TextEditingController usernameController=new TextEditingController();
  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 30.0,left: 15.0),
                      padding: EdgeInsets.all(5.0),
                      height: 90,
                      width: 52,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                          ]
                      ),
                      child: Container(
                        child: Text("S ",style: TextStyle(color: Colors.white,fontSize: 70.0,fontWeight: FontWeight.w600),),
                      )
                  ),
                  Text("ign ",style: TextStyle(color: Colors.black87,fontSize: 70.0,fontWeight: FontWeight.w600),),
                  Container(
                      margin: EdgeInsets.only(top: 30.0,left: 5.0),
                      padding: EdgeInsets.all(5.0),
                      height: 80,
                      width: 52,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                          ]
                      ),
                      child: Center(
                        child: Container(
                          child: Text("U",style: TextStyle(color: Colors.white,fontSize: 60.0,fontWeight: FontWeight.w600),),
                        ),
                      )
                  ),
                  Text("p",style: TextStyle(color: Colors.black87,fontSize: 70.0,fontWeight: FontWeight.w600),),
                ],
              ),

              Container(
                margin: EdgeInsets.only(left: 15.0),
                padding: EdgeInsets.only(left: 5.0),
                height: 70,
                width: 270,
                child: Text("with Farrago",style: TextStyle(color: Colors.black87,fontSize: 20.0,fontWeight: FontWeight.w400),),
              ),

              SizedBox(height: 30.0,),

              Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text("Enter username",style: TextStyle(color: Colors.black87),),
                      ),

                      Container(
                        width: Get.width-Get.width/5,
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              )
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
                        child: Text("Enter email",style: TextStyle(color: Colors.black87),),
                      ),

                      Container(
                        width: Get.width-Get.width/5,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              )
                          ),
                          validator: (value){
                            if(!value.endsWith("@gmail.com")){
                              return "Please enter valid email-id!";
                            }
                            else  return null;
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
                        child: Text("Enter password",style: TextStyle(color: Colors.black87),),
                      ),

                      Container(
                        width: Get.width-Get.width/5,
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.security_rounded),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              )
                          ),
                          validator: (value){
                            if(value.length<8){
                              return "Password length must be atleast 8!";
                            }
                            else  return null;
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 7.0,left: 5.0),
                        child: Text("forgot password?",style: TextStyle(color: Colors.red),),
                      ),

                          SizedBox(width: 30,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: ()=> validateForm(),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20.0,right: Get.width/6),
                                  height: 45.0,
                                  width: Get.width/3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                    color: Colors.blueAccent,
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
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("   Go ahead",style: TextStyle(color: Colors.white,fontSize: 15.0),),
                                      Icon(Icons.navigate_next,color: Colors.white,size: 30.0,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void validateForm(){
    if(formKey.currentState.validate()){
      print("Form validated successfully");
      userController.registerUser(usernameController.text, emailController.text, passwordController.text);
    }else{

    }
  }
}
