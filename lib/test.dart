import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Listening to Firestore collection stream
        stream: FirebaseFirestore.instance.collection('itemMaster').snapshots(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // Show a loading indicator while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Extract data from snapshot
          final data = snapshot.data;
          final documents = data?.docs ?? [];

          if (documents.isEmpty) {
            return Center(
              child: Text('No products available.'),
            );
          }

          // Display data in a ListView
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final product = documents[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['productDesc'] ?? 'No Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'SKU: ${product['skuNumber'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Category: ${product['category'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cost: \$${product['cost']?.toStringAsFixed(2) ?? '0.00'}',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          Text(
                            'Selling Price: \$${product['sellingPrice']?.toStringAsFixed(2) ?? '0.00'}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Location: ${product['location'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Status: ${product['isListed'] == true ? 'Listed' : 'Not Listed'}',
                        style: TextStyle(
                          color: product['isListed'] == true
                              ? Colors.blue
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
