import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventorymanagement/addProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventorymanagement/itemDetails.dart';

import 'Components/productDetailStatus.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  // soldAction(product){
  //   print('product');
  // }
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List',style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
          backgroundColor: Colors.teal[700],
      ),
        backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('itemMaster').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          final documents = data?.docs ?? [];
          if (documents.isEmpty) {
            return Center(
              child: Text('No products available.'),
            );
          }
          return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final product = documents[index].data() as Map<String, dynamic>;
            return SizedBox(
              height: 150,
              width: screenWidth,
              child: GestureDetector(
                onTap:(){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetails(data: product)),
                        (Route<dynamic> route) => false,
                  );
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetails(data:product)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product['productDesc'] ??
                                      'No Description', style: TextStyle(
                                    fontSize: 20,
                                                        // Larger size for the product name
                                    fontWeight: FontWeight.bold,
                                                        // Bold for prominence
                                    color: Colors
                                        .black87, // Slightly darker for readability
                                  ),),
                                  Text(
                                    'SKU: ${product['skuNumber'] ?? 000}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors
                                          .black54, // Lighter color for cost
                                    ),),
                                ],

                              ),
                              Column(
                                children: [
                                  Text(
                                    'Is Sold: ${product['sold'] == true
                                        ? 'Yes'
                                        : 'No'}', style: TextStyle(
                                    color: product['sold'] == true
                                        ? Colors.red
                                        : Colors.grey[600],),
                                  ),
                                  Text(
                                    'Listed On FB: ${product['isListed'] ==
                                        true ? 'Yes' : 'No'}',
                                    style: TextStyle(
                                      color: product['isListed'] == true
                                          ? Colors.blue
                                          : Colors.grey[600],),

                                  ),
                                  Text(
                                    'On Hold: ${product['isPending'] == true
                                        ? 'Yes'
                                        : 'No'}', style: TextStyle(
                                    color: product['isPending'] == true
                                        ? Colors.blue
                                        : Colors.grey[600],),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            );
          }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ItemsMaster()),
                (Route<dynamic> route) => false,
          );
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsMaster()));
        },
        child: Icon(Icons.add,color: Colors.white70), // Icon displayed on the button
        backgroundColor: Colors.teal[700],
        // Button color
      ),
    );

  }
}
