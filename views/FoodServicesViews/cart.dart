import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class Cart extends StatelessWidget {

  final RestrauntController restrauntController = Get.put(RestrauntController());
  TextEditingController hostelNameController=new TextEditingController();
  TextEditingController roomNumberController=new TextEditingController();
  GlobalKey<FormState> formKey=new GlobalKey<FormState>();
  String hostelName;
  int roomNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.shopping_cart,color: Colors.black54,size: 120,),
                ),

                SizedBox(height: 15.0,),

                StreamBuilder(
                  stream: restrauntController.cartStream,
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                    if(!snapshot.hasData){
                      return Container(child: Center(child: CircularProgressIndicator(),),);
                    }

                    if(RestrauntController.fetchingData){
                      return Container(child: Center(child: CircularProgressIndicator(),),);
                    }

                    restrauntController.fetchAmountToPay(snapshot);
                    return Container(
                        height: (Get.height/2+30),
                        child:
                        snapshot.data.docs.length==0 ? Center(child: Text("Cart is empty",style: TextStyle(fontSize: 20),),) :
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Obx(()=> Text("Amount to pay:  Rs.${restrauntController.totalAmountToPay.value}",style: TextStyle(color: Colors.black54,fontSize: 20),),)
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 20.0,right: 20.0),
                              child: Divider(height: 5.0, thickness:1, color: Colors.black54,),
                            ),

                            SizedBox(height: 15.0,),

                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context,int index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        margin: EdgeInsets.only(top: 2,bottom: 2,left: 5,right: 5),
                                        height: 70.0,
                                        width: Get.width/2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("${snapshot.data.docs[index]['item']}",style: TextStyle(color: Colors.white),),
                                              Text("Price : Rs.${snapshot.data.docs[index]['price']} /piece",style: TextStyle(color: Colors.white),)
                                            ],
                                          ),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap:()=> restrauntController.decrementQuantity(snapshot.data.docs[index].reference,snapshot.data.docs[index]['quantity']),
                                        child: Container(
                                          height:30.0,
                                          width:30.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color:Colors.grey[400],
                                          ),
                                          child: Center(
                                            child: Icon(Icons.remove,color: Colors.black,),
                                          ),
                                        ),
                                      ),

                                      RestrauntController.fetchingData ? Container(child: Center(child: CircularProgressIndicator(),),) : Text("${snapshot.data.docs[index]['quantity']}"),

                                      GestureDetector(
                                        onTap:()=> restrauntController.incrementQuantity(snapshot.data.docs[index].reference,snapshot.data.docs[index]['quantity']),
                                        child: Container(
                                          height:30.0,
                                          width:30.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color:Colors.grey[400],
                                          ),
                                          child: Center(
                                            child: Icon(Icons.add,color: Colors.black,),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10,top: 15),
                      child: MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text("Place order  ",style: TextStyle(color: Colors.white),),
                            Icon(Icons.check_circle,color: Colors.white,size: 18.0,)
                          ],
                        ),
                        color: Colors.green,




                          onPressed: (){
                          Get.defaultDialog(
                            barrierDismissible: false,
                            title: "Enter details to proceed...",
                            radius: 10.0,
                            content: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0),
                                    child: Text("Enter Hostel name"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      controller: hostelNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                      ),

                                      validator: (value){
                                        if(value.length==0) return "Please enter valid name";
                                      },

                                    ),
                                  ),
                                  SizedBox(height: 30.0,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0),
                                    child: Text("Enter Room number"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      controller: roomNumberController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          )
                                      ),
                                      keyboardType: TextInputType.phone,

                                      validator: (value){
                                        if(value.length==0) return "Please enter valid number";
                                      },

                                    ),
                                  )
                                ],
                              ),
                            ),

                            actions: [
                              MaterialButton(
                                color: Colors.green,
                                child:Text("Confirm",style: TextStyle(color: Colors.white),),
                                onPressed: (){
                                  if(validateForm()){
                                    //we need to parse the room number because we are receiving it as string

                                    restrauntController.placeOrder(hostelName,roomNumber);

                                    Get.back();
                                  }
                                },
                              ),

                              MaterialButton(
                                color: Colors.redAccent,
                                child:Text("Cancel",style: TextStyle(color: Colors.white),),
                                onPressed: ()=> Get.back(),
                              ),

                            ]
                          );
//                          restrauntController.placeOrder(),
                        }
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  bool validateForm(){
    this.hostelName=hostelNameController.text;
    this.roomNumber=int.parse(roomNumberController.text);
    return formKey.currentState.validate();
  }
}
