import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farrago/models/FoodServicesModels/CartItem.dart';
import 'package:farrago/models/FoodServicesModels/OrderItem.dart';
import 'package:farrago/models/User/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../models/FoodServicesModels/Restraunt.dart';

class RestrauntController extends GetxController{

  static bool fetchingData=true;
  String restrauntLocation;
  String restrauntName;
  String itemSelected;
  String itemType;
  int quantity=1;
  var totalAmountToPay=0.obs;

  Stream<QuerySnapshot> restrauntListStream;
  Stream<QuerySnapshot> menuStreamFood;
  Stream<QuerySnapshot> menuStreamDrinks;
  Stream<QuerySnapshot> menuStreamFoodItems;
  Stream<QuerySnapshot> menuStreamDrinkItems;
  Stream<QuerySnapshot> cartStream;
  Stream<QuerySnapshot> deliveryBoyDashboardStream;

  DocumentReference foodServicesReference = FirebaseFirestore.instance.collection("FoodServices").doc("PeRk88gfrJEwfIWnPG5U");
  CollectionReference cartReference = FirebaseFirestore.instance.collection("Users").doc(UserModel.uid).collection("foodCart");
  CollectionReference placedOrderReference = FirebaseFirestore.instance.collection("Users").doc(UserModel.uid).collection("placedOrder");
  CollectionReference ordersQueueReference = FirebaseFirestore.instance.collection("OrdersQueue");

  Future fetchRestrauntList(String location) async {
    fetchingData=true;
    restrauntLocation=location;
    restrauntListStream = foodServicesReference.collection(location).snapshots();
    fetchingData=false;
  }

  Future fetchMenu() async {
    fetchingData=true;
    menuStreamFood = foodServicesReference.collection(restrauntLocation).doc(restrauntName).collection("Food").snapshots();
    menuStreamDrinks = foodServicesReference.collection(restrauntLocation).doc(restrauntName).collection("Drinks").snapshots();
    fetchingData=false;
  }

  Future fetchFoodItems() async {
    fetchingData=true;
    menuStreamFoodItems = foodServicesReference.collection(restrauntLocation).doc(restrauntName).collection("Food").doc(itemSelected).collection(itemSelected).snapshots();
    fetchingData=false;
  }

  Future fetchDrinkItems() async {
    fetchingData=true;
    menuStreamDrinkItems = foodServicesReference.collection(restrauntLocation).doc(restrauntName).collection("Drinks").snapshots();
    fetchingData=false;
  }

  Future fetchCartItems() async {
    fetchingData=true;
    cartStream = cartReference.snapshots();
    fetchingData=false;
  }

  Future fetchAmountToPay(AsyncSnapshot<QuerySnapshot> snapshot) async {
    print("fetchAmountToPay() called");
    int amountSum=0;
    for(int docIndex=0;docIndex<snapshot.data.docs.length;docIndex++){
      amountSum+=(snapshot.data.docs[docIndex]['price']*snapshot.data.docs[docIndex]['quantity']);
    }

    print(totalAmountToPay.toString()+" updated");
    totalAmountToPay.value=amountSum;
  }

  void addToCart(CartItem cartItem,int price){
    //add item using cartItem controller
    Future<QuerySnapshot> alreadyAdded = cartReference.where('item',isEqualTo: cartItem.item).get();

    alreadyAdded.then((value) {
      if(value.docs.length==0){
        cartReference.add({
        'RestrauntName':cartItem.restrauntName,
        'RestrauntLocation':cartItem.location,
        'item':cartItem.item,
        'quantity':cartItem.quantity,
        'price':price
      });
      }else{
        value.docs[0].reference.update({
          'quantity':value.docs[0]['quantity']+1
        });
      }
    });
  }

  Future incrementQuantity(DocumentReference reference,int currentQuantity) async {
    print("incrementQuantity() called");
    RestrauntController.fetchingData=true;
    //increase quantity
    reference.update({
      'quantity':currentQuantity+1,
    });
    RestrauntController.fetchingData=false;
  }

  Future decrementQuantity(DocumentReference reference,int currentQuantity) async {
    print("decrementQuantity() called");
    RestrauntController.fetchingData=true;
    if(currentQuantity==1){
      //remove item from cart
      cartReference.doc(reference.id).delete().whenComplete(() => print("Item deleted from cart"));

    }else{
      //decrease quantity
      reference.update({
      'quantity':currentQuantity-1,
      });
    }
    RestrauntController.fetchingData=false;
  }


  Future placeOrder(String hostelName, int roomNumber) async {
    List<OrderItem> userOrderList=List.empty(growable: true);
    cartStream = cartReference.snapshots();
    cartStream.forEach((element){
      for(int docIndex=0 ; docIndex < element.docs.length ; docIndex++){
        userOrderList.add(new OrderItem(location: element.docs[docIndex]['RestrauntLocation'],restrauntName: element.docs[docIndex]['RestrauntName'],item: element.docs[docIndex]['item'],price: element.docs[docIndex]['price'],quantity: element.docs[docIndex]['quantity']));
      }

      //if we declare it using empty then it will throw exception bcz in that the size of the list would be 0,so it cannot add anything there
      var array=new List.filled(userOrderList.length, {},growable: true);
      for(int i=0 ; i < userOrderList.length ; i++) {
        OrderItem orderItem = userOrderList.elementAt(i);
        array[i]={'location': orderItem.location,'restrauntName': orderItem.restrauntName,'item': orderItem.item,'price': orderItem.price,'quantity': orderItem.quantity};
      }

      ordersQueueReference.add({
        'accepted':false,
        'buyerName':UserModel.name,
        'buyerContact':'9306324547',
        'delivererName':"Ritik",
        'delivererContact':'8199009408',
        'hostelName':hostelName,
        'roomNumber':roomNumber,
        'items':array,
      });
      
    });
  }
  
  Future fetchOrderQueue() async {
    fetchingData=true;
    deliveryBoyDashboardStream = ordersQueueReference.snapshots();
    fetchingData=false;
  }
}