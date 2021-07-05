import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDescription extends StatelessWidget {

  RestrauntController restrauntController = Get.put(new RestrauntController());

  int index;//index of order picked
  List itemsOrdered;

  OrderDescription(int index){
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("Order Description",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back),color: Colors.black,),
      ),

      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: restrauntController.deliveryBoyDashboardStream,
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

            if(!snapshot.hasData){
              return Container(child: Center(child: CircularProgressIndicator(),),);
            }

            itemsOrdered = snapshot.data.docs[index]['items'];

            return snapshot.data.docs.length == 0 ?
            Container(child: Center(child: Text("fetching data..."),),) :
            Container(
              color: Colors.grey[400],
              margin: EdgeInsets.only(top: 10.0,left: 7.0,right: 7.0,bottom: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(children : [Text("Buyer Name : "+snapshot.data.docs[index]['buyerName'],style: TextStyle(fontSize: 17.0),),]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child : Row(children : [Text("Buyer Contact : "+snapshot.data.docs[index]['buyerContact'],style: TextStyle(fontSize: 17.0),)]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(children : [Text("Deliverer Name : "+snapshot.data.docs[index]['delivererName'],style: TextStyle(fontSize: 17.0),),]),
                  ),

                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child : Row(children : [Text("Deliverer Contact : "+snapshot.data.docs[index]['delivererContact'],style: TextStyle(fontSize: 17.0),),])
                  ),

                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child : Row(children : [Text("Hostel : "+snapshot.data.docs[index]['hostelName'],style: TextStyle(fontSize: 17.0),),])
                  ),

                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child : Row(children : [Text("Room no. : "+(snapshot.data.docs[index]['roomNumber']).toString(),style: TextStyle(fontSize: 17.0),),])
                  ),

                  Container(
                    margin: EdgeInsets.all(7),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.grey[600],),
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child : Row(children : [Text("Items ordered : ",style: TextStyle(fontSize: 17.0),),])
                        ),

                        itemsOrdered.length == 0 ? Center(child: CircularProgressIndicator(),) :
                        Container(
                          height: 300,
                          child: ListView.builder(
                              itemCount: itemsOrdered.length,
                              itemBuilder: (context,int index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15.0,),
                                    Container(
                                      color:Colors.grey[500],
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("Item : "+itemsOrdered[index]['item']),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text("Location : "+itemsOrdered[index]['location']),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text("Restraunt name : "+itemsOrdered[index]['restrauntName']),
                                    )
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                          height: 40.0,
                          width: Get.width/2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: snapshot.data.docs[index]['accepted'] ? Colors.green : Colors.redAccent,
                          ),

                          child: Center(
                            child: Text(snapshot.data.docs[index]['accepted'] ? "Accepted" : "Not accepted yet!",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      )
    );
  }
}
