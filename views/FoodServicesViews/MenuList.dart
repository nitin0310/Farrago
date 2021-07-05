import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:farrago/views/FoodServicesViews/MenuDrinkItem.dart';
import 'package:farrago/views/FoodServicesViews/MenuFoodItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuList extends StatelessWidget {

  final RestrauntController restrauntController = Get.put(RestrauntController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black87,),onPressed: ()=> Get.back()),
          title: Text("Farrago",style: TextStyle(color: Colors.black87),),
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black87,)),
          ],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0,),
            Container(
              margin: EdgeInsets.only(left: 15.0,bottom: 15.0),
                child: Text("Explore food items",style: TextStyle(fontSize: 18.0,color: Colors.black87),)
            ),
            Container(
              height: 180,
              child: Expanded(
                child: StreamBuilder(
                  stream: restrauntController.menuStreamFood,
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                    if(!snapshot.hasData){
                      return Container(child: Center(child: CircularProgressIndicator(),),);
                    }

                    if(RestrauntController.fetchingData){
                      return Container(child: Center(child: CircularProgressIndicator(),),);
                    }

                    if(snapshot.data.size==0){//size
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          height: 60,
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.error,color: Colors.redAccent,),
                                Text("No items available",style: TextStyle(color: Colors.grey[600],fontSize: 17.0),)
                              ],
                            ),
                          ),
                        ),
                      );
                    }else {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              restrauntController.itemType="Food";
                              restrauntController.itemSelected=snapshot.data.docs[index]['Name'].toString();
                              restrauntController.fetchFoodItems();
                              Get.to(()=> MenuFoodItem(),transition: Transition.rightToLeft);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0,top:5.0,bottom: 5.0),
                              height: 30.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                color: Colors.blue[600],
                              ),
                              child: Center(
                                child: Text(snapshot.data.docs[index]['Name']),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 15.0,bottom: 15.0,top: 15.0),
                child: Text("Explore drinks",style: TextStyle(fontSize: 18.0,color: Colors.black87),)
            ),
            Container(
              height: 180,
              child: Expanded(
                child: StreamBuilder(
                  stream: restrauntController.menuStreamDrinks,
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                    if(!snapshot.hasData){
                      return Container(child: Center(child: CircularProgressIndicator(),),);
                    }

                    if(RestrauntController.fetchingData){
                      return Container(child: Center(child: CircularProgressIndicator(),),);
                    }

                    if(snapshot.data.size==0){//size
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          height: 60,
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.error,color: Colors.redAccent,),
                                Text("No items available",style: TextStyle(color: Colors.grey[600],fontSize: 17.0),)
                              ],
                            ),
                          ),
                        ),
                      );
                    }else {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              restrauntController.itemType="Drinks";
                              restrauntController.fetchDrinkItems();
                              Get.to(()=> MenuDrinkItem(),transition: Transition.rightToLeft);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 5.0),
                              height: 30.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                color: Colors.blue[600],
                              ),
                              child: Center(
                                child: Text(snapshot.data.docs[index]['Name']),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
