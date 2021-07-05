import 'package:farrago/controllers/Authentication/AuthController.dart';
import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:farrago/models/User/UserModel.dart';
import 'package:farrago/views/FoodServicesViews/RestrauntList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestrauntLocation extends StatelessWidget {

  RestrauntController _restrauntController = Get.put(RestrauntController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                _restrauntController.fetchRestrauntList("InsideHostel");
                _restrauntController.restrauntLocation="InsideHostel";
                Get.to(()=>RestrauntList(),transition: Transition.rightToLeft);
              },
              child: Container(
                margin: EdgeInsets.only(top:20.0),
                width: 130,
                height: 130,
                child: Center(child: Text("Inside Hostel",style: TextStyle(color: Colors.black87),),),
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
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                _restrauntController.fetchRestrauntList("OutsideHostel");
                _restrauntController.restrauntLocation="OutsideHostel";
                Get.to(()=>RestrauntList(),transition: Transition.rightToLeft);
              },
              child: Container(
                margin: EdgeInsets.only(top:20.0),
                width: 130,
                height: 130,
                child: Center(child: Text("Outside Hostel",style: TextStyle(color: Colors.black87),),),
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
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
