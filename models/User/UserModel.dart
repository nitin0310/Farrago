import 'package:get/get.dart';

class UserModel{
  static String name;
  static String email;
  static String uid;
  static bool isDeliveryBoy;

  static void setData(String name,String email,String uid,bool isDeliveryBoy){
    UserModel.name=name;
    UserModel.email=email;
    UserModel.uid=uid;
    UserModel.isDeliveryBoy = isDeliveryBoy;
  }
}
