import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'itemDetails.dart';

class ManageEmployee extends StatelessWidget {
  const ManageEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('Userprofiles').snapshots(),
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
    child: Text('No Users available.'),
    );
    }
    return ListView.builder(
    itemCount: documents.length,
    itemBuilder: (context, index) {
    final user = documents[index].data() as Map<String, dynamic>;
    return SizedBox(
    height: 150,
    width: 100,
    child: GestureDetector(
    onTap:(){
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => ItemDetails(data: user)),
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
    Text(user['empName'] ??
    'No Name', style: TextStyle(
    fontSize: 20,
    // Larger size for the product name
    fontWeight: FontWeight.bold,
    // Bold for prominence
    color: Colors
        .black87, // Slightly darker for readability
    ),),
    Text(
    'Email: ${user['email'] ?? '' }',
    style: TextStyle(
    fontSize: 16,
    color: Colors
        .black54, // Lighter color for cost
    ),),
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
    );
  }
}
