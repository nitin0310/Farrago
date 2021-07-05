import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDrinkItem extends StatelessWidget {
  RestrauntController restrauntController=Get.put(RestrauntController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black87,),onPressed: ()=>Get.back(),),
          title: Text("Farrago",style: TextStyle(color: Colors.black87),),
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black87,)),
          ],
        ),

        body: Column(
          children: [
            SizedBox(height: 20.0,),
            Expanded(
              child: StreamBuilder(
                stream: restrauntController.menuStreamFoodItems,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                  if(!snapshot.hasData){
                    return Container(child: Center(child: CircularProgressIndicator(),),);
                  }

                  if(RestrauntController.fetchingData){
                    return Container(child: Center(child: CircularProgressIndicator(),),);
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index){
                      return Container(
                        height: 80,
                        color: Colors.blue,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
