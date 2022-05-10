import 'package:flutter/widgets.dart';

//Simple class used to group items
//this is seperated from other files because i use it in multiple places

class SaleItem {
  double price = 0.00;
  Image? img;
  String? name;
  List<String> type;
  int size;
  int amount = 1;

  SaleItem(this.price, this.img, this.name, this.type, this.size);
}
