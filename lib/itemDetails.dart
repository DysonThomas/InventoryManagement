import 'package:flutter/material.dart';
import 'package:inventorymanagement/homescreen.dart';

class ItemDetails extends StatefulWidget {
  final Map data;
  const ItemDetails({super.key, required this.data});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: ()=>  Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen())), icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('Product Details',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
        child: SizedBox(
          width: screenWidth,
          height: 3/4*screenheight,
          child: Container(

            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
            BoxShadow(
            color: Colors.black, // Shadow color with some transparency
            blurRadius: 10, // How blurred the shadow is
            spreadRadius: 2, // How much the shadow spreads
            offset: Offset(5, 5), // Shadow position (horizontal, vertical)
          ),],
                borderRadius: BorderRadius.circular(16),
          ),
            child: Column(
              children: <Widget>[
                  Column(
                    children: [
                      Text('Desc'),
                      Text('cost'),
                      Text('Qty'),
                      Text('Status'),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
