import 'package:farrago/controllers/FoodServices/RestrauntController.dart';
import 'package:farrago/views/FoodServicesViews/MenuList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestrauntList extends StatelessWidget {

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
          children: [
            Expanded(
              child: StreamBuilder(
                stream: restrauntController.restrauntListStream,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(child: Center(child: CircularProgressIndicator(),),);
                  }

                  if(RestrauntController.fetchingData){
                    return Container(child: Center(child: CircularProgressIndicator(),),);
                  }

                  return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: snapshot.data.size,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            restrauntController.restrauntName=snapshot.data.docs[index]['Name'];
                            restrauntController.fetchMenu();
                            Get.to(()=> MenuList(),transition: Transition.rightToLeft);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0),
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.all(Radius.circular(20)),
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

                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${snapshot.data.docs[index]['Name']}",style: TextStyle(fontSize: 25.0),),
                                  Text("${snapshot.data.docs[index]['ItemCount']}"),
                                  RatingBarIndicator(
                                    rating: snapshot.data.docs[index]['Rating']*1.0,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    itemCount: 5,
                                    unratedColor: Colors.black12,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Available : "),
                                      Icon(snapshot.data.docs[index]['Open'] ? Icons.check_circle_outline:Icons.cancel,
                                        color: snapshot.data.docs[index]['Open'] ? Colors.green:Colors.redAccent,
                                        size: 15.0,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder:(index)=> StaggeredTile.fit(1)
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
