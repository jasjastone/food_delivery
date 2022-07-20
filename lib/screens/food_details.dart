// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/components/app_drawer.dart';
import 'package:food_delivery/utils/auth.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import '../utils/cart.dart';

class FoodDetails extends StatefulWidget {
  dynamic item;
  FoodDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  var size, height, width;
  var paddingRatio = 0.068;

  //picking center
  String? pickingCenter = "Mianzini Center";
  bool isPickingFromCenter = false;

  bool addedToCart = false;

  var images = [
    'https://unsplash.com/photos/0tgMnMIYQ9Y/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8OHx8aW1hZ2UlMjBwbGFpbiUyMHdoaXRlfGVufDB8fHx8MTY1NDE1OTgyOQ&force=true&w=640'
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController quantityController;
  //firestore instance

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityController = TextEditingController(text: "1");
  }

  final db = FirebaseFirestore.instance;

  var dropDownValue = '1. Pick from the merchant';
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var checkedValue = "";
    PageController _pageController = PageController(viewportFraction: 0.8);
    // const List<String> _kOptions = <String>[
    //   'aardvark',
    //   'bobcat',
    //   'chameleon',
    // ];

    // // add images to pageview
    // if (widget.item.data().toString().contains('img1') &&
    //     widget.item.get('img1') != '') {
    //   images[0] = widget.item.get('img1');
    // }
    // if (widget.item.data().toString().contains('img2') &&
    //     widget.item.get('img2') != '') {
    //   images.add(widget.item.get('img2'));
    // }
    // if (widget.item.data().toString().contains('img3') &&
    //     widget.item.get('img3') != '') {
    //   images.add(widget.item.get('img3'));
    // }

    // var item_price = widget.item.data().toString().contains('price')
    //     ? widget.item.get('price')
    //     : '';
    // var item_name = widget.item.data().toString().contains('name')
    //     ? widget.item.get('name')
    //     : '';
    // var item_owner = widget.item.data().toString().contains('uid')
    //     ? widget.item.get('uid')
    // : '';
    // var item_price = widget.item.data().toString().contains('price')
    //     ? widget.item.get('price')
    //     : '';

    GlobalKey formKey = GlobalKey();
    return Scaffold(

        appBar: AppBar(
          title: Text(widget.item.get('name'),
              style: TextStyle(color: Colors.white)),
        ),
        body: Container(
            padding: EdgeInsets.only(bottom: 60),
            child: ListView(children: [
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * paddingRatio,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                          widget.item.get('img1'),
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "TZS ${widget.item.get('price')}",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${widget.item.get('name')}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  )),
            ])),
        bottomSheet: Container(
            height: 60,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: width * paddingRatio),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //     icon: Icon(Icons.store_mall_directory_outlined),
                //     onPressed: () {}),
                AuthHelper().user.uid != widget.item.get('uid') ? Expanded(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.pink.shade700,
                            Colors.pink.shade500,
                            Colors.pink.shade300,
                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.3), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: Builder(builder: (context) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size.fromHeight(50),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              //make color or elevated button transparent
                            ),
                            onPressed: () {
                              // ScaffoldMessenger.of(context).show
                              Cart()
                                  .addItem(
                                widget.item.id,
                                widget.item.get('name'),
                                "1",
                                widget.item.get("price"),
                                widget.item.get('uid'),
                              )
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Added Successfully")));
                              }).onError((err, stactrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(err.toString())));
                              });
                              setState(() {
                                addedToCart = false;
                              });
                            },
                            child: Text("Add to Cart"));
                      })),
                ): Container(),
                // DecoratedBox(
                //     decoration: BoxDecoration(
                //         gradient: LinearGradient(colors: [
                //           Colors.teal,
                //           Colors.teal.shade300,
                //           //add more colors
                //         ]),
                //         borderRadius: BorderRadius.circular(30),
                //         boxShadow: const <BoxShadow>[
                //           BoxShadow(
                //               color:
                //                   Color.fromRGBO(0, 0, 0, 0.3), //shadow for button
                //               blurRadius: 5) //blur radius of shadow
                //         ]),
                //     child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           primary: Colors.transparent,
                //           onSurface: Colors.transparent,
                //           shadowColor: Colors.transparent,
                //           padding:
                //               EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                //           //make color or elevated button transparent
                //         ),
                //         onPressed: () {},
                //         child: Text("Buy Now"))),
              ],
            )));
  }
}
