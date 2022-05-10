import 'dart:ui';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CartPage.dart';
import 'SaleItem.dart';
import 'StorePageController.dart';
import 'item.dart';

class StorePage extends StatelessWidget {
  StorePage({Key? key}) : super(key: key);
  swaPage(Widget f, BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => f,
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 100),
        ));
  }

  final StorePageController c = Get.find();
  @override
  Widget build(BuildContext context) {
    double sizeW = MediaQuery.of(context).size.width;
    double sizeH = MediaQuery.of(context).size.height;
    c.Start(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return SizedBox(
      width: sizeW,
      height: sizeH,
      child: Scaffold(
          appBar: AppBar(
              actions: [
                Builder(builder: ((context) {
                  return IconButton(
                    icon: const Icon(Icons.contact_support),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                })),
              ],
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: const Color.fromARGB(0, 255, 255, 255),
              title: const Text('Store',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'WaterBrush',
                      fontSize: 25,
                      color: Colors.black))),
          backgroundColor: Color.fromARGB(255, 241, 241, 241),
          drawer: Drawer(
              child: ListView(
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(95, 26, 64, 33),
                ),
                child: Text('Cool Things',
                    style: TextStyle(
                        fontFamily: 'WaterBrush', color: Colors.black)),
              ),
              ListTile(
                title: Text('Home'),
              ),
              ListTile(title: Text('Sale')),
              ListTile(title: Text('test'))
            ],
          )),
          endDrawer: Drawer(
              child: ListView(
            children: const [ListTile(title: Text('Contact us\n345-806-3245'))],
          )),
          body: Column(
            children: [
              Row(children: [
                SizedBox(width: sizeW * 0.05),
                Container(
                    child: Column(children: [
                      const Text('BUY THIS COW',
                          style: TextStyle(
                              fontFamily: 'Poppin',
                              fontSize: 25,
                              color: Colors.green)),
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: const Text('BUY NOW',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            c.add(c.item.last);
                            c.update();
                          })
                    ]),
                    height: sizeH * 0.2,
                    width: sizeW * 0.9,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('images/main/cow.png')))),
                SizedBox(width: sizeW * 0.05)
              ]),
              SizedBox(height: sizeH * 0.05),
              SizedBox(
                height: sizeH * 0.065,
                width: sizeW,
                child: ItemList(
                  sizeH: sizeH,
                  sizeW: sizeW,
                ),
              ),
              SizedBox(height: sizeH * 0.01),
              UpdatingText(sizeW: sizeW, sizeH: sizeH),
              SizedBox(
                height: sizeH * 0.4,
                width: sizeW * 0.9,
                child: Grid_(),
              ),
              SizedBox(
                height: sizeH * 0.0125,
              ),
              BottomBar(),
            ],
          )),
    );
  }
}

//ItemList is the assembler for the ListItems
class ItemList extends StatefulWidget {
  const ItemList({Key? key, required this.sizeH, required this.sizeW})
      : super(key: key);
  final double sizeH;
  final double sizeW;
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final ScrollController _controller = ScrollController();

  final StorePageController c = Get.find();
  late double sizeH;
  late double sizeW;
  @override
  // ignore: must_call_super
  void initState() {
    sizeH = widget.sizeH;
    sizeW = widget.sizeW;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (int i = 1; i < c.list_size.value; i++) {
      items.add(GetBuilder<StorePageController>(
          builder: (controller) =>
              ListItem(sizeH: sizeH, sizeW: sizeW, x: c.list.elementAt(i))));
    }
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: Expanded(
        flex: 1,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: items,
        ),
      ),
    );
  }
}

//ScrollBehavior is a last minute fix for web browsers since scrolls doesn't work right on them
//this was taken from online
//was planning to add a link to the stackoverflow page but i lost it
class ScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

//These don't need to be stateful but i had a different plan in mind before hand
//The listItem takes an Item class object and uses it to build a selector button
class ListItem extends StatefulWidget {
  const ListItem(
      {Key? key, required this.x, required this.sizeH, required this.sizeW})
      : super(key: key);
  final Item x;
  final double sizeH;
  final double sizeW;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late double sizeH;
  late double sizeW;
  late Item x;
  final StorePageController s = Get.find();
  @override
  void initState() {
    super.initState();
    x = widget.x;
    sizeH = widget.sizeH;
    sizeW = widget.sizeW;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: sizeH * 0.05,
        width: sizeW * 0.35,
        margin: EdgeInsets.only(left: sizeW * 0.05),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(45)),
            color: s.isActive(x.index) ? Colors.orange : Colors.white),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(45)),
            onTap: () {
              s.changedSelected(x.index);
              s.UpdateGrid();
              s.update();
            },
            child: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  child: x.i,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                  ),
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 10),
                x.t
              ],
            )));
  }
}

//This is for the updating row and the show all button
class UpdatingText extends StatelessWidget {
  UpdatingText({Key? key, required this.sizeW, required this.sizeH})
      : super(key: key);
  final StorePageController s = Get.find();
  final double sizeW;
  final double sizeH;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: sizeW * 0.045),
        SizedBox(
          width: sizeW * 0.3,
          child: Obx(() {
            String? j = s.list[s.selected.value].t.data;
            return Expanded(
                flex: 2,
                child: Text(j!, style: GoogleFonts.poppins(fontSize: 16)));
          }),
        ),
        SizedBox(width: sizeW * 0.4),
        MaterialButton(
          onPressed: () {
            s.selected.value = 0;
            s.UpdateGrid();
            s.update();
          },
          child: const Text(
            'see all',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        )
      ],
    );
  }
}

//Takes a object saleitem
//returns a visual gridItem representing the saleItem
class GridItem extends StatelessWidget {
  GridItem(
      {Key? key, required this.item, required this.sizeH, required this.sizeW})
      : super(key: key);
  final SaleItem item;
  final double sizeH;
  final double sizeW;
  final StorePageController s = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
          width: sizeW * 0.2,
          height: sizeH * 0.14,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white),
          child: Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                    child: item.img!,
                    width: sizeW * 0.25,
                    height: sizeH * 0.10),
                Text(
                  item.size.toString() + 'L',
                  textAlign: TextAlign.left,
                ),
                Text(item.name!, textAlign: TextAlign.left),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: sizeW * 0.30,
                  child: Row(
                    children: [
                      Text('\$' + item.price.toString()),
                      SizedBox(width: sizeW * 0.08),
                      SizedBox(
                        width: sizeH * 0.05,
                        height: sizeH * 0.05,
                        child: MaterialButton(
                            onPressed: () {
                              s.add(item);
                              s.update();
                            },
                            child: const Icon(Icons.add)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

//Assembler for GridItems in the same way that ItemList returns a list of ListItems
class Grid_ extends StatelessWidget {
  Grid_({Key? key}) : super(key: key);
  StorePageController p = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StorePageController>(
        builder: (controller) => GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.95,
              ),
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              children: p.c,
            ));
  }
}

//Displays total and allows for navigation to cart
class BottomBar extends StatelessWidget {
  BottomBar({Key? key}) : super(key: key);
  final StorePageController c = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 2,
      child: Container(
        width: width,
        height: height * 0.10,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: width * 0.1),
            IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => const CartPage(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: const Duration(milliseconds: 100),
                      ));
                }),
            SizedBox(width: width * 0.1),
            GetBuilder<StorePageController>(
                builder: (controller) => Text(
                    'Total: ' + c.getValue().toStringAsPrecision(4) + ' \$'))
          ],
        ),
      ),
    );
  }
}
