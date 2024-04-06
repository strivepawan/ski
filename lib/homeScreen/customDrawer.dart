import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting registration date
import 'package:cloud_firestore/cloud_firestore.dart'; // For user data storage

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _mobileNo = '';
  String _email = '';
  DateTime? _registrationDate;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _name = user.displayName ?? '';
        _email = user.email ?? '';
        _registrationDate = user.metadata.creationTime;
      });
      // Fetch user data from Firestore (optional)
      final docSnapshot = await _users.doc(user.uid).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        setState(() {
          _name = (userData as Map<String, dynamic>)?['name'] ?? _name;
          _mobileNo = (userData as Map<String, dynamic>)?['mobileNo'] ?? '';
        });
      }
    }
  }

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = _auth.currentUser;
      if (user != null) {
        // Update user data in Firestore
        await _users.doc(user.uid).update({
          'name': _name,
          'mobileNo': _mobileNo,
          'email': _email,
          // Add other user fields as needed
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile Updated Successfully!')),
        );
      } else {
        print('No user signed in');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_name),
              accountEmail: Text(_email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    _auth.currentUser?.photoURL ?? 'https://picsum.photos/200'),
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              trailing: Icon(Icons.edit),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Edit Profile'),
                    content: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: _name,
                              decoration: InputDecoration(labelText: 'Name'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter your name' : null,
                              onSaved: (newValue) =>
                                  setState(() => _name = newValue!),
                            ),
                            TextFormField(
                              initialValue: _mobileNo,
                              decoration:
                                  InputDecoration(labelText: 'Mobile Number'),
                              keyboardType: TextInputType.phone,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your mobile number'
                                  : null,
                              onSaved: (newValue) =>
                                  setState(() => _mobileNo = newValue!),
                            ),
                            TextFormField(
                              initialValue: _email,
                              decoration: InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter your email' : null,
                              onSaved: (newValue) =>
                                  setState(() => _email = newValue!),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _updateUserProfile,
                        child: Text('Update'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text('My Location'),
              trailing: Icon(Icons.location_on),
              onTap: () {
                // Implement logic to show or edit user's location
              },
            ),
            ListTile(
              title: Text('Registered On'),
              subtitle: _registrationDate != null
                  ? Text(DateFormat('dd MMM yyyy').format(_registrationDate!))
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
