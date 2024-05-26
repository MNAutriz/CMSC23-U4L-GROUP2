import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';

class AddressField extends StatefulWidget {
  final bool isPickupChecked;
  final DonorForm formData;

  AddressField({super.key, required this.isPickupChecked, required this.formData});

  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  List<String> addresses = [];
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                return _buildListTile(addresses[index]);
              },
            ),
            Padding(
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
                        icon: const Icon(Icons.add, color: Color(0xFF3D8361)),
                        onPressed: () {
                          final newAddress = _textFieldController.text;
                          if (newAddress.isNotEmpty) {
                            setState(() {
                              addresses.add(newAddress);
                              _textFieldController.clear();
                              widget.formData.pickupAddresses = addresses;  // Update formData
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
        if (widget.isPickupChecked && addresses.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter at least one address.'),
            ),
          );
          return 'Please enter at least one address';
        }
        return null;
      },
      onSaved: (value) {
        widget.formData.pickupAddresses = value!;
        debugPrint(widget.formData.pickupAddresses.toString());
      },
    );
  }

  Widget _buildListTile(String address) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    address,
                    style: const TextStyle(
                      color: Color(0xFF3D8361),
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
                    widget.formData.pickupAddresses = addresses;  // Update formData
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
