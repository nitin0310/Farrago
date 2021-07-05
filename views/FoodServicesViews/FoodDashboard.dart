import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:farrago/views/FoodServicesViews/RestrauntLocation.dart';
import 'package:farrago/views/FoodServicesViews/cart.dart';
import 'package:farrago/views/FoodServicesViews/PlacedOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodDashboard extends StatelessWidget {

  final RestrauntController restrauntController = Get.put(RestrauntController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          centerTitle: true,
          title: Text("Farrago",style: TextStyle(color: Colors.black87),),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black87,),onPressed: ()=>Get.back(),),
          actions: [
            IconButton(icon: Icon(Icons.history_toggle_off_sharp,color: Colors.black87,),onPressed: (){
              Get.to(()=> PlacedOrder());
            },),

            IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black87,),onPressed: (){
              restrauntController.fetchCartItems();
              Get.to(()=> Cart());
            },)
          ],
        ),

        body: RestrauntLocation(),
      ),
    );
  }
}
