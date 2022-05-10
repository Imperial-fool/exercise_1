import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'StorePage.dart';
import 'StorePageController.dart';
import 'item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final StorePageController c = Get.put(StorePageController());
    //this is all used to initilize icons for the middle bar, was trying to make this look nicer but this works!
    Item i = Item(const Image(image: AssetImage('images/icons/2_percent.png')),
        const Text(''));
    i.setIndex(0);
    c.addList(i);
    i = Item(const Image(image: AssetImage('images/icons/2_percent.png')),
        const Text('2%'));
    i.setIndex(1);
    c.addList(i);
    i = Item(const Image(image: AssetImage('images/icons/3_percent.png')),
        const Text('3%'));
    c.addList(i);
    i.setIndex(2);
    i = Item(const Image(image: AssetImage('images/icons/alternative.jpeg')),
        const Text('Milk Alts'));
    c.addList(i);
    i.setIndex(3);
    i = Item(const Image(image: AssetImage('images/icons/lactose_free.jpeg')),
        const Text('Lactose Free'));
    c.addList(i);
    i.setIndex(4);

    return GetMaterialApp(
      title: 'ShopFront',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Milk Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  onSwipe() {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => StorePage(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 100),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //GestureDetector is used for page navigation besides that this home page is sorta bland, used the normal navigator instead of getx because i wasn't using it yet!

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        onSwipe();
      },
      child: Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("images/main/cow.png"))),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .7,
                  ),
                  const SizedBox(
                    child: Text("Milk Stand",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontFamily: 'WaterBrush', fontSize: 50)),
                  ),
                  SizedBox(
                    child: Column(children: [
                      const Icon(Icons.keyboard_double_arrow_up),
                      const SizedBox(height: 10),
                      Text('Get Started',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins())
                    ]),
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ))),
    );
  }
}
