import 'package:flutter/material.dart';

class PlacedOrder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        elevation: 0.0,
        title: Text("Placed Orders",style: TextStyle(color: Colors.black87),),
        leading: Container(),
      ),
      backgroundColor: Colors.grey[300],


    );
  }
}
