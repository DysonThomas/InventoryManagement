import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventorymanagement/InputComponent.dart';
import 'package:inventorymanagement/boolwidget.dart';
import 'package:inventorymanagement/homescreen.dart';

class addUsers extends StatefulWidget {
  const addUsers({super.key});

  @override
  State<addUsers> createState() => _addUsersState();
}

class _addUsersState extends State<addUsers> {
  final TextEditingController _EmpName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _status = TextEditingController();
  final TextEditingController _role = TextEditingController();
  String empname = '';
  String address ='';
  String email = '';
  String password ='';
  String status = '';
  bool role = false;
  Future<bool> isUnique(String sku) async{
    QuerySnapshot snapshot= await await FirebaseFirestore.instance.collection('products')
        .where('sku', isEqualTo: sku)
        .get();
    return snapshot.docs.isEmpty;
  }
  void _saveUser(BuildContext context) async {
    print(_EmpName.text+
        _address.text+
        _email.text +
        _password.text+
        _status.text);
    bool unique = await isUnique(_email.text);
    if(unique) {
      if ((_EmpName.text.isEmpty ||
          _address.text.isEmpty ||
          _email.text.isEmpty ||
          _password.text.isEmpty ||
          _status.text.isEmpty)){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Stop further execution if validation fails
      }

      try {
        await FirebaseFirestore.instance.collection('Userprofiles').add({
          'empName': empname,
          'address': address,
          'email': email,
          'password': password,
          'status': status,
          'role': role??'False',
        });
        _EmpName.text = '';
        _address.text = '';
        _email.text = '';
        _password.text = '';
        _status.text = '';
        _role.text = '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
      catch (e) {
        // Handle the error and display a message
        print("Error saving item: $e");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add item. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,top: 15,right: 8),
          child: Column(
            children: [
            // Name
              InputFieldss(textLabel: 'Enter Employee Name',
                  hintText: 'Dyson Thomas', controller: _EmpName,
                  onChanged: (value){
                    empname = value;
                  }),
              InputFieldss(textLabel: 'Address',
                  hintText: '35 Genevive Crescent', controller: _address,
                  onChanged: (value){
                    address = value;
                  }),
              InputFieldss(textLabel: 'Email',
                  hintText: 'dyson.thomas@gmail.com', controller: _email,
                  onChanged: (value){
                    email = value;
                  }),
              InputFieldss(textLabel: 'Password',
                  hintText: '*********', controller: _password,
                  onChanged: (value){
                    password = value;
                  }),
              InputFieldss(textLabel: 'Current Status',
                  hintText: 'Student', controller: _status,
                  onChanged: (value){
                    status = value;
                  }),
            Boolwidget(textLabel: 'Admin ? ', hintText:'isAdmin', controller: _role, onChanged: (value){
              print(value);
            role=value;
            print(role);
            }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _saveUser(context);
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
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LandingScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900], // Dark blue background
                      padding: EdgeInsets.symmetric(vertical: 16), // Increases height
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
