import 'package:flutter/material.dart';

class DonationTypeField extends StatefulWidget {
  const DonationTypeField({Key? key}) : super(key: key);

  @override
  State<DonationTypeField> createState() => _DonationTypeFieldState();
}

class _DonationTypeFieldState extends State<DonationTypeField> {
  List<String> initialTypes = [
    'Food',
    'Clothes',
    'Cash',
    'Necessities',
  ];

  List<String> additionalTypes = [];

  Map<String, bool> isCheckedMap = {};

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initialTypes.forEach((type) {
      isCheckedMap[type] = false;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder( // listview builder for default categories
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: initialTypes.length,
          itemBuilder: (context, index) {
            final type = initialTypes[index];
            return _buildListTile(type); // function to build custom widget
          },
        ),
        ListView.builder( // listview builder to render added categories
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: additionalTypes.length + 1, // +1 is for the textfield
          itemBuilder: (context, index) {
            if (index == additionalTypes.length) { // if index == to end of array (insert add new category textfield)
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'New Category',
                        labelStyle: TextStyle(color: const Color(0xFF3D8361).withOpacity(0.3)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add, color: Color(0xFF3D8361)),
                          onPressed: () {
                            final newCategory = _textFieldController.text.trim();
                            if (newCategory.isNotEmpty && !_categoryExists(newCategory)) { // also check if newCategory is already belonging to initial types
                              setState(() { // add new category to separate array
                                additionalTypes.add(newCategory);
                                isCheckedMap[newCategory] = true; // assign initial value to true so that it is selected by default
                                _textFieldController.clear(); // clear controller
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              final type = additionalTypes[index];
              return _buildListTile(type);
            }
          },
        ),
      ],
    );
  }

  bool _categoryExists(String newCategory) {
  // Check if the new category exists in either initialTypes or additionalTypes, ignoring case
  // .any iterates through list and checks each element and stops if condition is true then returns true; else return false
  return initialTypes.any((type) => type.toLowerCase() == newCategory.toLowerCase()) ||
      additionalTypes.any((type) => type.toLowerCase() == newCategory.toLowerCase());
}

  // custom function to build custom widget with remove button
  Widget _buildListTile(String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    type,
                    style: TextStyle(
                      color: isCheckedMap[type] == false ? const Color(0xFF3D8361) : const Color(0xFFEEF2E6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!initialTypes.contains(type)) // add remove button if not initial type
                IconButton(
                  icon: Icon(Icons.remove, color: isCheckedMap[type] == false ? const Color(0xFF3D8361) : const Color(0xFFEEF2E6),),
                  onPressed: () {
                    setState(() {
                      additionalTypes.remove(type);
                      isCheckedMap.remove(type);
                    });
                  },
                ),
            ],
          ),
          tileColor: isCheckedMap[type] == false ? Colors.white : const Color(0xFF3D8361),
          onTap: () {
            setState(() {
              isCheckedMap[type] = !(isCheckedMap[type] ?? false);
            });
          },
        ),
      ),
    );
  }
}
