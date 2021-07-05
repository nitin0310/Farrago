import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:farrago/models/FoodServicesModels/CartItem.dart';
import 'package:farrago/views/FoodServicesViews/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuFoodItem extends StatelessWidget {
  RestrauntController restrauntController = Get.put(RestrauntController());


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
            IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black87,),onPressed: (){
              restrauntController.fetchCartItems();
              Get.to(()=> Cart());
            },),
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
                          margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                          padding: EdgeInsets.all(5.0),
                          height: 120,
                          decoration: BoxDecoration(
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
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${snapshot.data.docs[index].id}"),
                                    ],
                                  ),


                                  Align(
                                      alignment: Alignment.bottomRight,
                                        child: MaterialButton(
                                          onPressed: (){
                                            //ask for quantity
                                            restrauntController.itemSelected=snapshot.data.docs[index].id.toString();
                                            restrauntController.addToCart(new CartItem(restrauntName: restrauntController.restrauntName,location: restrauntController.restrauntLocation,item: restrauntController.itemSelected,quantity: restrauntController.quantity),snapshot.data.docs[index]['Price']);
                                            Get.snackbar("Order status", "${snapshot.data.docs[index].id} Added successfully, Edit item in cart");
                                          },
                                          color: Colors.black,
                                          height: 120,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.add_shopping_cart,color: Colors.white70,size: 30,),
                                              Text("Add to cart",style: TextStyle(color: Colors.white70,fontSize: 13),)
                                            ],
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
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
