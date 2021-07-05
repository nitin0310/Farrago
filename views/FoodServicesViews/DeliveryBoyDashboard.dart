import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:farrago/views/FoodServicesViews/OrderDescription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryBoyDashboard extends StatelessWidget {

  RestrauntController restrauntController = Get.put(new RestrauntController());

  DeliveryBoyDashboard(){
    restrauntController.fetchOrderQueue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],

        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0.0,
          leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back,color: Colors.black,)),
        ),

        body: StreamBuilder(
          stream: restrauntController.deliveryBoyDashboardStream,
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

            if(!snapshot.hasData){
              return Container(child: Center(child: CircularProgressIndicator(),),);
            }

            if(RestrauntController.fetchingData){
              return Container(child: Center(child: CircularProgressIndicator(),),);
            }

            return snapshot.data.docs.length == 0 ?
            Container(child: Center(child: Text("Nothing to deliver"),),) :

            ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context,int index){
                  return Padding(
                      padding: EdgeInsets.only(left: 7.0,right : 7.0),
                      child : ListTile(
                        onTap: () => Get.to(OrderDescription(index)),
                        title: Text(snapshot.data.docs[index]['buyerName']+" | "+snapshot.data.docs[index]['hostelName']),
                        tileColor: (index % 2) != 0 ? Colors.grey[300] : Colors.grey[400],
                        leading: Icon(Icons.pending,color: Colors.black45,),
                      )
                  );
                }
            );
          },
        ),
      ),
    );
  }

}
