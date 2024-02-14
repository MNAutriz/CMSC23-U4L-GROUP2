main() {
  //fixed list of numbers
  const List<int> input_list = [1, 3, 1, 4, 3, 1, 5, 5, 3, 2, 5, 6, 8];

  //storage for products (unique number multiplied to its occurances)
  List<int> products = [];

  print("Number of occurences:");

  //list of numbers that were already scanned in our fixed list of numbers
  List<int> scanned = [];

  //every number in input_list will assessed
  for (int item in input_list) {
    int count = 0; //number of occurances
    //every number in input_list willl be compared to the variable 'item'
    for (int item2 in input_list) {
      //of encountered same number (count will be appended)
      if (item == item2) {
        count = count + 1;
      }
    }

    bool isSeen = false;
    //if number is already assessed
    for (int num in scanned) {
      if (item == num) {
        isSeen = true;
        break;
      }
    }

    //if the number is a unique number
    if (isSeen == false) {
      scanned.add(item);
      print('\t' + item.toString() + ': ' + count.toString());
      products.add(item * count);
    }
  }

  //conversion to string
  String stringProducts = products.toString();

  //removing the brackets
  stringProducts = stringProducts.replaceAll('[', '');
  stringProducts = stringProducts.replaceAll(']', '');
  print('Products: ' + stringProducts);
}