import 'package:exercise_1/StorePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'SaleItem.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          title: const Text('Cart',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'WaterBrush', fontSize: 25, color: Colors.black)),
          leading: Builder(builder: ((context) {
            return IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pop(context),
            );
          })),
        ),
        body: Column(
          children: [
            GetBuilder<StorePageController>(
                builder: (controller) => BodyBuilder_()),
            total(),
          ],
        ));
  }
}

//Assembler for BodyItems
class BodyBuilder_ extends StatelessWidget {
  BodyBuilder_({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StorePageController s = Get.find();
    List<BodyItem> list = [];
    for (var element in s.content) {
      list.add(BodyItem(item: element));
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      child: ListView(
        children: list,
      ),
    );
  }
}

//Pretty much a copy and past of GridItem but slightly different
class BodyItem extends StatelessWidget {
  BodyItem({Key? key, required this.item}) : super(key: key);
  SaleItem item;
  StorePageController s = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const SizedBox(width: 15),
            SizedBox(
              child: item.img,
              width: 25,
              height: 25,
            ),
            const SizedBox(width: 10),
            Text(item.name!),
            const SizedBox(width: 10),
            Text(item.price.toString() + '\$'),
            const SizedBox(width: 10),
            Text(item.amount.toString()),
            IconButton(
                onPressed: () {
                  s.removeItem(item);
                  s.update();
                },
                icon: const Icon(Icons.remove)),
          ],
        ));
  }
}

//calculates total and returns updated text object whenever state changes
class total extends StatelessWidget {
  total({Key? key}) : super(key: key);
  StorePageController s = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<StorePageController>(
            builder: (controller) =>
                Text('Total: ' + s.getValue().toStringAsPrecision(4) + ' \$')));
  }
}
