import 'package:firebase_database/firebase_database.dart';

import 'edit_info.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'more_info.dart';

class StlessProducts extends StatelessWidget {
  const StlessProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AllProducts();
  }
}

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    final ref = fb.reference().child('Products');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenHW = (screenWidth * screenHeight) / 200;
    double widthBlock = screenWidth / 100;
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: null,
          body: Stack(
            children: [
              FutureBuilder(
                  future: ref.once(),
                  builder: (context,
                      AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      lists.clear();
                      Map<dynamic, dynamic> values =
                          snapshot.data!.value;
                      values.forEach((key, values) {
                        lists.add(values);
                      });
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              if (snapshot.hasData) {
                                lists.clear();
                                Map<dynamic, dynamic> values =
                                    snapshot.data!.value;
                                values.forEach((key, values) {
                                  lists.add(values);
                                });
                              }
                            });
                          },
                          // ignore: unnecessary_null_comparison
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: lists.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return NeumorphicButton(
                                  onPressed: () {
                                    Index = index.toInt();
                                    nameContEdt.text = lists [index] ["Name"];
                                    packageContEdt.text = lists [index] ["Package Count"];
                                    pieceContEdt.text =  lists [index] ["Pieces Per Package"];
                                    packageBuyingPriceContEdt.text = lists [index] ["Package Buying Price"];
                                    pieceSellingPriceContEdt.text = lists [index] ["Piece Selling Price"];
                                    barcodeContEdt.text = lists [index] ["Barcode"];
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                MoreInfo()));
                                  },
                                  margin: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.012,
                                      horizontal: screenWidth * 0.05),
                                  style: NeumorphicStyle(
                                    boxShape:
                                    NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(22)),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.01),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          child: Hero(
                                            tag: 'avatar',
                                            child: NeumorphicButton(
                                              onPressed: () {},
                                              padding: EdgeInsets.all(
                                                  ((screenHeight +
                                                      screenWidth) /
                                                      2) *
                                                      0.005),
                                              style: NeumorphicStyle(
                                                boxShape:
                                                NeumorphicBoxShape
                                                    .circle(),
                                                depth: -2,
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage:
                                                new NetworkImage(
                                                    ''),
                                                backgroundColor:
                                                Colors.white38,
                                                radius:
                                                screenHeight * 0.03,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Hero(
                                              tag: 'name',
                                              child: Text(
                                                "Name: " +
                                                    lists[index]
                                                    ["Name"],
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: screenHeight * 0.02,
                                                ),
                                              ),
                                            ),
                                            Hero(
                                              tag: 'left',
                                              child: Text(
                                                "Left: " + lists[index]["Pieces Left"].toString(),
                                              ),
                                            ),
                                            Hero(
                                              tag: 'barcode',
                                              child: Text(
                                                "Barcode: " + lists[index]["Barcode"],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          )
                      );
                    }
                    return Center(
                        child: RefreshProgressIndicator()
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

