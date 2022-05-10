import 'package:flutter/widgets.dart';

//Item class for stores info for the oval buttons
class Item {
  Image i;
  Text t;
  late int index;
  Item(this.i, this.t);
  setIndex(int i) => index = i;
}
