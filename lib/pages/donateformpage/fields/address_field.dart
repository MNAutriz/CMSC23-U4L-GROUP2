import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/donor_form.dart';
import 'package:cmsc23project/models/donor_model.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/providers/donor_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressField extends StatefulWidget {
  final bool isPickupChecked;
  final DonorForm formData;

  AddressField({
    Key? key,
    required this.isPickupChecked,
    required this.formData,
  }) : super(key: key);

  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  List<String> addresses = [];
  TextEditingController _textFieldController = TextEditingController();
  List<dynamic>? firestoreAddress;
  List<String> _selectedAddresses = [];

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserAuthProvider>().user; // get logged in user
    return StreamBuilder<QuerySnapshot>(
      stream: context.read<DonorProvider>().donor,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        //get id of donor
        String id = snapshot.data!.docs
            .firstWhere((doc) => doc['email'] == user!.email)['id'];

        // Extract address of logged in user from donor collection
        firestoreAddress = snapshot.data!.docs
            .firstWhere((doc) => doc['email'] == user!.email)['address'];

        // Add existing addresses from firebase
        if (addresses.isEmpty && firestoreAddress != null) {
          addresses = firestoreAddress!.map((a) => a.toString()).toList();
        }

        return FormField<List<String>>(
          initialValue: addresses,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    return _buildListTile(addresses[
                        index]); // custom method to build each address
                  },
                ),
                Padding(
                  // widget for new address field
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'New Address',
                          labelStyle: TextStyle(
                            color: const Color(0xFF3D8361).withOpacity(0.3),
                          ),
                          suffixIcon: IconButton(
                            icon:
                                const Icon(Icons.add, color: Color(0xFF3D8361)),
                            onPressed: () {
                              final newAddress = _textFieldController.text;
                              if (newAddress.isNotEmpty) {
                                setState(() {
                                  // when plus button pressed, add new address to address list and clear textfieldcontroller
                                  addresses.add(newAddress);

                                  _selectedAddresses.add(
                                      newAddress); // Add the new address to the selected list
                                  _textFieldController.clear();
                                  debugPrint(addresses.toString());
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          validator: (value) {
            if (widget.isPickupChecked && _selectedAddresses.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select at least one address.'),
                ),
              );
              return 'Please select at least one address';
            }
            return null;
          },
          onSaved: (value) {
            widget.formData.pickupAddresses = _selectedAddresses.toList();
            debugPrint(widget.formData.pickupAddresses.toString());
          },
        );
      },
    );
  }

  Widget _buildListTile(String address) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: _selectedAddresses.contains(address)
            ? Colors.green[100]
            : Colors.white,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    address,
                    style: TextStyle(
                      color: _selectedAddresses.contains(address)
                          ? Colors.green[800]
                          : const Color(0xFF3D8361),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.remove, color: const Color(0xFF3D8361)),
                onPressed: () {
                  setState(() {
                    addresses.remove(address);
                    _selectedAddresses.remove(address);
                  });
                },
              ),
            ],
          ),
          onTap: () {
            // on tap card
            setState(() {
              if (_selectedAddresses.contains(address)) {
                // if address is already in _selectedAdresses
                _selectedAddresses.remove(address); // remove
              } else {
                _selectedAddresses.add(address); // add
              }
            });
          },
        ),
      ),
    );
  }
}
