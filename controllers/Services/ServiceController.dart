import 'package:farrago/models/Services/Service.dart';
import 'package:farrago/models/User/UserModel.dart';
import 'package:farrago/views/ClothingServicesViews/ClothingDashboard.dart';
import 'package:farrago/views/FoodServicesViews/DeliveryBoyDashboard.dart';
import 'package:farrago/views/FoodServicesViews/FoodDashboard.dart';
import 'package:farrago/views/MainViews/Dashboard.dart';
import 'package:farrago/views/RentingServicesViews/RentingDashboard.dart';
import 'package:farrago/views/SalonServicesViews/SalonDashboard.dart';
import 'package:farrago/views/StationeryServicesViews/StationeryDashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController{
  final services=List<Service>.empty().obs;
  final servicesRoutes=List.empty();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  void fetchData(){
    services.add(new Service(name: "Food Services",isAvailable: true,imgUrl: 'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'));
    services.add(new Service(name: "Salon Services",isAvailable: false,imgUrl: 'https://images.pexels.com/photos/331989/pexels-photo-331989.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'));
    services.add(new Service(name: "Stationery Services",isAvailable: true,imgUrl: 'https://images.pexels.com/photos/1018133/pexels-photo-1018133.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'));
    services.add(new Service(name: "Renting Services",isAvailable: true,imgUrl: 'https://img2.pngio.com/stack-of-books-the-william-mary-blogs-stack-of-books-wallpaper-png-1920_1080.png'));
    services.add(new Service(name: "Clothing Services",isAvailable: false,imgUrl: 'https://images.pexels.com/photos/581087/pexels-photo-581087.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'));
  }

  void navigateToPage(int index){

    switch(index){
      case 0:
        UserModel.isDeliveryBoy ? Get.to(() => DeliveryBoyDashboard()) : Get.to(() => FoodDashboard());
        break;
      case 1:
        Get.to(() => SalonDashboard());
        break;
      case 2:
        Get.to(() => StationeryDashboard());
        break;
      case 3:
        Get.to(() => RentingDashboard());
        break;
      case 4:
        Get.to(() => ClothingDashboard());
        break;
    }
  }

}