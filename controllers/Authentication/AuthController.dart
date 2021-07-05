import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:farrago/models/User/UserModel.dart';
import 'package:farrago/views/FoodServicesViews/DeliveryBoyDashboard.dart';
import 'package:farrago/views/MainViews/Dashboard.dart';
import 'package:farrago/views/MainViews/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController{

  FirebaseAuth _auth=new FirebaseAuth.instanceFor(app: Firebase.app());
  CollectionReference usersReference = FirebaseFirestore.instance.collection("Users");
  CollectionReference deliveryBoyReference = FirebaseFirestore.instance.collection("DeliveryBoy");
  RestrauntController restrauntController=Get.put(new RestrauntController());     //used to trigger fetch dashboard data for delivery boy
  static bool signedIn = false;

  void registerUser(String username,String email,String password) async {
     _auth.createUserWithEmailAndPassword(email: email,password: password).then((value) {
       Get.defaultDialog(title: "Loading",content: CircularProgressIndicator());

       usersReference.doc(value.user.uid.toString()).set(             //to user reference
           {
             "userName":username,
             "email":email,
             "isDeliveryBoy":false,
           }
       );

       usersReference.doc(value.user.uid).get().then((snapshots) {
         UserModel.setData(snapshots.get("userName"), snapshots.get("email"), value.user.uid,false);
       });

       Get.offAll(()=> Dashboard());

     }).catchError((error) => Get.snackbar("Error while creating account.", error.toString(),snackStyle: SnackStyle.FLOATING));
  }

  void signInUser(String email,String password){
    _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      Get.defaultDialog(title: "Loading",content: CircularProgressIndicator());
      usersReference.doc(value.user.uid).get().then((snapshots) {
        UserModel.setData(snapshots.get("userName"), snapshots.get("email"), value.user.uid,snapshots.get("isDeliveryBoy"));
      });
      Get.offAll(()=> Dashboard());
    }).catchError((error) => Get.snackbar("Error while signing in.", error.toString(),snackStyle: SnackStyle.FLOATING));
  }

  void signOut(){
    _auth.signOut().then((value) => Get.offAll(SplashScreen())).catchError((error) => Get.snackbar("Error while signing out.", error.toString()));
  }
}