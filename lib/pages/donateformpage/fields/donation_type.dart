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
          itemCount: additionalTypes.length + 1,
          itemBuilder: (context, index) {
            if (index == additionalTypes.length) { // if index == to end of array (insert add new category textfield)
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'New Category',
                        labelStyle: TextStyle(color: const Color(0xFF3D8361).withOpacity(0.3)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            final newCategory = _textFieldController.text.trim(); // trim to remove white spaces
                            if (newCategory.isNotEmpty) {
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

  // custom function to build custom widget with remove button
  Widget _buildListTile(String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  type,
                  style: TextStyle(
                    color: isCheckedMap[type] == false ? const Color(0xFF3D8361) : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!initialTypes.contains(type))
                IconButton(
                  icon: const Icon(Icons.remove),
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
