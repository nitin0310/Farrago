import 'package:farrago/controllers/Authentication/AuthController.dart';
import 'package:farrago/controllers/Services/ServiceController.dart';
import 'package:farrago/models/User/UserModel.dart';
import 'package:farrago/views/FoodServicesViews/DeliveryBoyDashboard.dart';
import 'package:farrago/views/FoodServicesViews/FoodDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {

  ServiceController _serviceController = Get.put(ServiceController());
  AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],elevation: 0.0,
          actions: [
            IconButton(icon: Icon(Icons.account_circle_rounded,color: Colors.black87,)),
            IconButton(icon: Icon(Icons.logout,color: Colors.black87,),onPressed: ()=> _authController.signOut(),)
          ],
          title: Text("Farrago",style: TextStyle(color: Colors.black87,fontSize: 25.0,fontWeight: FontWeight.w600),),
        ),

        body: AuthController.signedIn ? Column(children: [ Expanded(
              child: Obx(()=> StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: _serviceController.services.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: () => _serviceController.services[index].isAvailable ? _serviceController.navigateToPage(index): Get.snackbar("Status", "",messageText: Text("Currently not available",style: TextStyle(color: Colors.red),),barBlur: 15.0),

                    child: Container(
                      margin: EdgeInsets.only(left: 10.0,top: 20.0,right: 10.0),
                      padding: EdgeInsets.only(left: 5.0,top: 5.0,right: 5.0,bottom: 5.0),
                      width: Get.width/2,
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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


                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(height: 5.0,),
                              CircleAvatar(
                                backgroundImage: NetworkImage(_serviceController.services[index].imgUrl),
                                backgroundColor: Colors.grey[300],radius: 60.0,),
                              Text("${_serviceController.services[index].name}",style: TextStyle(color: Colors.white,fontSize: 17.0),),
                            ],
                          ),
                        ),
                        height: 230.0,
                        width: Get.width/2,
                        decoration: BoxDecoration(
                          color: _serviceController.services[index].isAvailable ? Colors.blueAccent : Colors.redAccent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    )
                  );
                },
                staggeredTileBuilder: (index)=> StaggeredTile.fit(1),
              )),
            ),],) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}