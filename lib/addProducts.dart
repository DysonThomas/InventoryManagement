import 'package:flutter/material.dart';
import 'package:inventorymanagement/boolwidget.dart';
import 'package:inventorymanagement/dateWidget.dart';
import 'package:inventorymanagement/homescreen.dart';
import 'InputComponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ItemsMaster extends StatelessWidget {
  ItemsMaster({super.key});
  final TextEditingController _skunumber = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _receivingdate = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _sellingprice = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _isSold = TextEditingController();
  final TextEditingController _ispending = TextEditingController();
  final TextEditingController _isListed = TextEditingController();

String skunumber='';
String description='';
String category='';
String location='';
int quantity=0;
double sellingprice=0.0;
double cost=0.0;
DateTime recDate = DateTime.now();
bool isPending = false;
bool isListed = false;


  void _saveItem(BuildContext context) async {
    if (_skunumber.text.isEmpty ||
        _description.text.isEmpty ||
        _location.text.isEmpty ||
        _quantity.text.isEmpty ||
        _cost.text.isEmpty ||
        _sellingprice.text.isEmpty ||
        _category.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Stop further execution if validation fails
    }

    try {
    await FirebaseFirestore.instance.collection('itemMaster').add({
        'skuNumber': skunumber,
        'productDesc': description,
        'category': category,
        'quantity': quantity,
        'sellingPrice': sellingprice,
        'cost': cost,
        'ReceivingDate': recDate,
        'isPending': isPending,
        'isListed': isListed,
      });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    }
    catch(e){
      // Handle the error and display a message
      print("Error saving item: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add item. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading:       IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen())); }, icon: Icon(Icons.arrow_back),),
        title: Text('Add Product'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.question_mark_outlined),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
        child: SingleChildScrollView(
          child: Column(
          
            children: <Widget>[
              InputFieldss(textLabel: 'Enter Product Number',
                  hintText: 'N25', controller: _skunumber,
                  onChanged: (value){

                 skunumber = value;
                  }),
              InputFieldss(
                textLabel: 'Description',
                hintText: 'Enter Description',
                controller: _description,
                onChanged: (value) {
                  description=value;
                },
              ),
              InputFieldss(
                textLabel: 'Location',
                hintText: 'Enter Location',
                controller: _location,
                onChanged: (value) {
                  location=value;
                },
              ),
              InputFieldss(
                textLabel: 'Quantity',
                hintText: 'Enter Quantity',
                controller: _quantity,
                onChanged: (value) {
                  quantity=int.parse(value);
                },
              ),
              DateWidget(
                textLabel: 'Receiving Date',
                hintText: 'Enter Receiving Date',
                controller: _receivingdate,
                onChanged: (date) {
                  recDate = date; // Handle receiving date change
                  recDate=recDate; // Verify date
                },
              ),
              InputFieldss(
                textLabel: 'Cost',
                hintText: 'Enter Cost',
                controller: _cost,
                onChanged: (value) {
                  cost=double.parse(value);
                },
              ),
              InputFieldss(
                textLabel: 'Selling Price',
                hintText: 'Enter Selling Price',
                controller: _sellingprice,
                onChanged: (value) {
                  sellingprice=double.parse(value);
                },
              ),
              InputFieldss(
                textLabel: 'Category',
                hintText: 'Enter Category',
                controller: _category,
                onChanged: (value) {
                  category=value;
                },
              ),

                  Boolwidget(textLabel: 'Is Listed', hintText: 'Choose Yes Or No',
                      controller: _isListed, onChanged: (value){;
                    isListed=value;}),
                  Boolwidget(textLabel: 'Is Pending', hintText: 'Choose Yes Or No',
                      controller: _ispending, onChanged: (value){isPending=value;}),
                //   Boolwidget(textLabel: 'Is Sold', hintText: 'Choose Yes Or No',
                //       controller: _isSold, onChanged: (value){isSold=value;}),
                // DateWidget(
                //   textLabel: 'Sold Date',
                //   hintText: 'Enter Sold Date',
                //   controller: _sellingdate,
                //   onChanged: (date) {
                //     recDate = date; // Handle receiving date change
                //     selldate = recDate; // Verify date
                //   },
                // ),
            SizedBox(
        width: double.infinity, // Makes the button take full width of its parent
        child: ElevatedButton(
            onPressed: () {
      _saveItem(context);
      },
        child: Text(
          'Save',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900], // Dark blue background
          padding: EdgeInsets.symmetric(vertical: 16), // Increases height
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
          // Text field where the user can input data
            ],
          ),
        ),
      ),
    );
  }
}
