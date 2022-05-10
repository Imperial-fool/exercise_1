import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'SaleItem.dart';
import 'StorePage.dart';
import 'item.dart';

class StorePageController extends GetxController {
  //this is a mess!
  //I'm not good at state management!

  //This was supposed to be a seperate class but i had no clue how to make the entire class observable (its probably bad practice anyways!)
  List<SaleItem> content = [];

  add(SaleItem i) {
    if (content.contains(i)) {
      content[content.indexOf(i)].amount++;
      return;
    }
    content.add(i);
  }

  removeItem(SaleItem i) {
    if (content.contains(i)) {
      if (content[content.indexOf(i)].amount > 1) {
        content[content.indexOf(i)].amount--;
        return;
      }
      content.remove(i);
    }
  }

  double getValue() {
    double value = 0;
    for (var element in content) {
      value += element.price * element.amount;
    }
    return value;
  }

  //this is just the list of items this app 'sells'
  List<SaleItem> item = [];
  var c = <GridItem>[].obs;
  List<double> price = [5.78, 4.98, 5.89, 4.77, 6.98, 3.47, 4.27, 4.98, 5.98];
  List<List<String>> type = [
    ['2%'],
    ['2%'],
    ['2%', 'Lactose Free'],
    ['2%'],
    ['3%'],
    ['Milk Alts'],
    ['Milk Alts'],
    ['Milk Alts'],
    ['Lactose Free', '3%']
  ];
  List<String> name = [
    'Natrel Fine-filtered 2%',
    'Natrel Fine-filtered 2%',
    'Natrel Lactose Free 2%',
    'Sealtest Partly Skimmed',
    'Natrel Fine-filtered 3%',
    'UnSweetened Almond',
    'Silk Coconut Beverage',
    'Silk Organic Soy',
    'Natrel Lactose Free 3%'
  ];

  List<int> size = [4, 2, 2, 2, 4, 2, 2, 2, 2];
  var width;
  var height;

  //Called at start to initialize all the saleitems
  Start(double i, double j) {
    width = i;
    height = j;
    for (int j = 0; j < price.length; j++) {
      item.add(SaleItem(
        price[j],
        Image(image: AssetImage('images/milk' + j.toString() + '.jpeg')),
        name[j],
        type[j],
        size[j],
      ));
    }
    item.add(SaleItem(
      1000.00,
      const Image(image: AssetImage('images/main/cow.png')),
      'Cow',
      ['Cow'],
      1,
    ));
    UpdateGrid();
  }

  //based on selected value will add different items to grid array
  UpdateGrid() {
    c.clear();
    for (int j = 0; j < item.length; j++) {
      if (selected.value == 0 && item[j].name != 'Cow') {
        c.add(GridItem(
          item: item[j],
          sizeH: height,
          sizeW: width,
        ));
      }
      if (item[j].type.contains(itemType()) && item[j].name != 'Cow') {
        c.add(GridItem(
          item: item[j],
          sizeH: height,
          sizeW: width,
        ));
      }
    }
    print(c.length);
  }

  var selected = 0.obs;
  var list = [].obs;
  var list_size = 0.obs;

  changedSelected(int i) => selected.value = i;
  addList(Item i) {
    list.add(i);
    list_size++;
  }

  bool isActive(int i) {
    if (i == selected.value) {
      return true;
    } else {
      return false;
    }
  }

  String itemType() {
    Item j = list[selected.value];
    String s = j.t.data!;
    return s;
  }

  Item getItem() {
    return list[selected.value];
  }
}
