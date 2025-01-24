import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventorymanagement/Components/actionButton.dart';
import 'package:inventorymanagement/Components/productDetailStatus.dart';
import 'package:inventorymanagement/Components/productDetailsFeatures.dart';
import 'package:inventorymanagement/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetails extends StatefulWidget {
  final Map data;
  const ItemDetails({super.key, required this.data});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  double expectedProfit=0;
  double earnedProfit=0;
  String formattedDate='';
  String formattedSoldDate='';
  // DateTime dateReceived=DateTime.now();
  void initState() {
    super.initState();
    expectedProfit = (widget.data['sellingPrice']??0)-(widget.data['cost']??0);
    if (widget.data['ReceivingDate'] is Timestamp) {
      DateTime dateReceived = (widget.data['ReceivingDate'] as Timestamp).toDate();
      formattedDate = "${dateReceived.year}-${dateReceived.month}-${dateReceived.day}";
    } else {
      formattedDate = "N/A"; // Fallback if date is not available
    }// Extracting just the date

      if (widget.data['sold'] ?? false) {
        DateTime dateSold = (widget.data['soldDate'] as Timestamp?)?.toDate() ?? DateTime.now();
        formattedSoldDate = "${dateSold.year}-${dateSold.month}-${dateSold.day}";
        earnedProfit = (widget.data['soldPrice'] ?? 0) - (widget.data['cost'] ?? 0);

      // Extracting just the date
    }
  }
  _markAsSold(String data) async{
    try{
      CollectionReference product = FirebaseFirestore.instance.collection('itemMaster');
      QuerySnapshot querySnapshot = await product.where('skuNumber', isEqualTo: data.toString()).get();
     print(querySnapshot);
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        Map<String, dynamic> updatedData = {
          'sold': true,     // Set 'sold' to true
          'isPending': false,
          'isListed':false,
          'soldDate':DateTime.now()
        };
        await docRef.update(updatedData);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));

      } else {
        print("No product found with skuNumber");
      }
    }
    catch(e){
      print("Error updating product status: $e");
    }
  }
  _markAsPending(String data) async{
    try{
      CollectionReference product = FirebaseFirestore.instance.collection('itemMaster');
      QuerySnapshot querySnapshot = await product.where('skuNumber', isEqualTo: data.toString()).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        Map<String, dynamic> updatedData = {
          'sold': false,
          'isPending': true,
          'isListed':false,
          'holdedDate':DateTime.now()
        };
        await docRef.update(updatedData);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));

      } else {
        print("No product found with skuNumber");
      }
    }
    catch(e){
      print("Error updating product status: $e");
    }
  }
  _markAsBackToStock(String data) async{
    try{
      CollectionReference product = FirebaseFirestore.instance.collection('itemMaster');
      QuerySnapshot querySnapshot = await product.where('skuNumber', isEqualTo: data.toString()).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        Map<String, dynamic> updatedData = {
          'sold': false,
          'isPending': false,
          'isListed':false,
          'holdedDate':''
        };
        await docRef.update(updatedData);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));

      } else {
        print("No product found with skuNumber");
      }
    }
    catch(e){
      print("Error updating product status: $e");
    }
  }
  _backToList(String data) async{
    try{
      CollectionReference product = FirebaseFirestore.instance.collection('itemMaster');
      QuerySnapshot querySnapshot = await product.where('skuNumber', isEqualTo: data.toString()).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        Map<String, dynamic> updatedData = {
          'sold': false,
          'isPending': false,
          'isListed':true,
        };
        await docRef.update(updatedData);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));

      } else {
        print("No product found with skuNumber");
      }
    }
    catch(e){
      print("Error updating product status: $e");
    }
  }
  _unList(String data) async{
    try{
      CollectionReference product = FirebaseFirestore.instance.collection('itemMaster');
      QuerySnapshot querySnapshot = await product.where('skuNumber', isEqualTo: data.toString()).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        Map<String, dynamic> updatedData = {
          'isListed':false,
        };
        await docRef.update(updatedData);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));
      } else {
        print("No product found with skuNumber");
      }
    }
    catch(e){
      print("Error updating product status: $e");
    }
  }
  _remove(String data)async{
    try{
      CollectionReference products = FirebaseFirestore.instance.collection('itemMaster');

      // Query to find the document based on skuNumber
      QuerySnapshot querySnapshot = await products.where('skuNumber', isEqualTo: data).get();

      // Check if a document with that skuNumber exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference of the first document found
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Delete the document
        await docRef.delete();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));
      } else {
        print("No product found with skuNumber.");
      }
    }
    catch(e){

    }
  }
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: screenWidth,
            height:screenheight,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Text(widget.data['productDesc']??'NA',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35
                                ),
                            ),
                              Container(
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  height: 20,
                                ),
                              ),
                              if(widget.data['sold']??false)
                              StatusBar(color: Colors.green, status: 'Sold'),
                              if(widget.data['isPending']??false)
                              StatusBar(color: Colors.yellow, status: 'Pending'),
                              if(widget.data['isListed']??false)
                              StatusBar(color: Colors.blue, status: 'Ad Posted'),
                              if((!widget.data['isListed']??true)&&(!widget.data['sold']??false))
                              StatusBar(color: Colors.red, status: 'Not Posted'),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FeaturesBox(label: 'Product Number', desc: widget.data['skuNumber']),
                                  FeaturesBox(label: 'Quantity available', desc: widget.data['quantity'].toString())
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FeaturesBox(label: 'Cost', desc: widget.data['cost'].toString()),
                                    FeaturesBox(label: 'Selling Price', desc: widget.data['sellingPrice'].toString())
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FeaturesBox(label: 'Market Value', desc: widget.data[''].toString()),
                                  FeaturesBox(label: 'Profit Expected', desc:expectedProfit.toString())
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FeaturesBox(label: 'Received Date', desc: formattedDate),]
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // if(widget.data['sold']??false)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FeaturesBox(label: 'Sold Price', desc: widget.data[''].toString()),
                                    FeaturesBox(label: 'Sold Date', desc: formattedSoldDate),
                                    FeaturesBox(label: 'Earned Profit',desc: earnedProfit.toString(),)
                                  ]
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (!(widget.data['sold'] ?? false))
                                 ActionButtons(label: 'Sold', clr: Colors.green, onPressed:()=> _markAsSold(widget.data['skuNumber']),),
                                  if((!widget.data['sold']??false)&&(!widget.data['isPending']??false&&(!widget.data['isListed']??false) ))//&&(widget.data['isListed']??false) this condtion can beused if  only listed ad need to hold
                                 ActionButtons(label: 'Pending', clr: Colors.yellow, onPressed:()=> _markAsPending(widget.data['skuNumber']),),
                                  if((!widget.data['sold']??false)&&(widget.data['isPending']??false))
                                    ActionButtons(label: 'Back To Stock', clr: Colors.red, onPressed:()=> _markAsBackToStock(widget.data['skuNumber']),),
                                  if((!widget.data['sold']??false)&&(!widget.data['isPending']??false)&&(!widget.data['isListed']??false) )
                                 ActionButtons(label: 'Ad Listed', clr: Colors.blue,onPressed:()=> _backToList(widget.data['skuNumber']),),
                                  if((!widget.data['sold']??false)&&(!widget.data['isPending']??false)&&(widget.data['isListed']??false) )
                                  ActionButtons(label: 'UnListed', clr: Colors.red, onPressed:()=> _unList(widget.data['skuNumber']),),
                                  ActionButtons(label: 'Remove Product', clr: Colors.deepOrange, onPressed:()=> _remove(widget.data['skuNumber']),),
                  
                                ],
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }


}
