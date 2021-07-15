import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';

final nameContEdt = TextEditingController(),
      packageBuyingPriceContEdt = TextEditingController(),
      pieceSellingPriceContEdt = TextEditingController(),
      barcodeContEdt = TextEditingController(),
      packageContEdt = TextEditingController(),
      pieceContEdt = TextEditingController();

late int piecesLeftCount;

class stlessEdit extends StatelessWidget {
  const stlessEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: EditInfo(),
      ),
    );
  }
}

class EditInfo extends StatefulWidget {
  const EditInfo({Key? key}) : super(key: key);

  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference().child('Products');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02),
                child: NeumorphicButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(
                      ((screenHeight + screenWidth) / 2) * 0.020),
                  style: NeumorphicStyle(
                    depth: -10,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: CircleAvatar(
                    backgroundImage: new NetworkImage(
                        'https://data.whicdn.com/images/272220414/original.gif'),
                    backgroundColor: Color(0xffeeeeee),
                    radius: screenHeight * 0.09,
                  ),
                ),
              ),
              NeumorphicButton(
                onPressed: () {},
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04),
                child: TextField(
                  controller: nameContEdt,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
              NeumorphicButton(
                onPressed: () {},
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04),
                child: TextField(
                  controller: packageContEdt,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Package Count',
                    border: InputBorder.none,
                  ),
                ),
              ),
              NeumorphicButton(
                onPressed: () {},
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04),
                child: TextField(
                  controller: pieceContEdt,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Pieces Per Package',
                    border: InputBorder.none,
                  ),
                ),
              ),
              NeumorphicButton(
                onPressed: () {},
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04),
                child: TextField(
                  controller: packageBuyingPriceContEdt,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Package Buying Price',
                    border: InputBorder.none,
                  ),
                ),
              ),
              NeumorphicButton(
                onPressed: () {},
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04),
                child: TextField(
                  controller: pieceSellingPriceContEdt,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Piece Selling Price',
                    border: InputBorder.none,
                  ),
                ),
              ),
              NeumorphicButton(
                onPressed: (){},
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04),
                child: TextField(
                  controller: barcodeContEdt,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Enter The New Barcode Manually',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicButton(
                      onPressed: (){
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Deleting')));
                          ref
                              .child('Product: ${barcodeContEdt.text}')
                              .remove().then((_) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        HomePage()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                    Text('Successfully Deleted')));
                            nameContEdt.clear();
                            packageContEdt.clear();
                            pieceContEdt.clear();
                            packageBuyingPriceContEdt.clear();
                            pieceSellingPriceContEdt.clear();
                            barcodeContEdt.clear();
                          }).catchError((onError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(onError)));
                          });
                        });
                      },
                      child: SizedBox(
                        width: screenWidth * 0.30,
                        height: screenHeight * 0.06,
                        child: Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize:
                                (screenHeight + screenWidth) / 2 * 0.04,
                                color: Colors.black54,
                              ),
                            )),
                      ),
                    ),
                    NeumorphicButton(
                      margin: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.05),
                      provideHapticFeedback: true,
                      onPressed: () {
                        if (nameContEdt.text.isNotEmpty &&
                            packageContEdt.text.isNotEmpty &&
                            pieceContEdt.text.isNotEmpty &&
                            packageBuyingPriceContEdt.text.isNotEmpty &&
                            pieceSellingPriceContEdt.text.isNotEmpty &&
                            barcodeContEdt.text.isNotEmpty) {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Adding')));
                            ref
                                .child('Product: ${barcodeContEdt.text}')
                                .set({
                              'Barcode': barcodeContEdt.text,
                              'Name': nameContEdt.text,
                              'Package Count': packageContEdt.text,
                              'Pieces Per Package': pieceContEdt.text,
                              'Package Buying Price':
                              packageBuyingPriceContEdt.text,
                              'Piece Selling Price':
                              pieceSellingPriceContEdt.text,
                            }).then((_) {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          HomePage()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                      Text('Successfully Added')));
                              nameContEdt.clear();
                              packageContEdt.clear();
                              pieceContEdt.clear();
                              packageBuyingPriceContEdt.clear();
                              pieceSellingPriceContEdt.clear();
                              barcodeContEdt.clear();
                            }).catchError((onError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(onError)));
                            });
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Make Sure To Fill All The Fields')));
                        }
                      },
                      child: SizedBox(
                        width: screenWidth * 0.30,
                        height: screenHeight * 0.06,
                        child: Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                              fontSize:
                              (screenHeight + screenWidth) / 2 * 0.04,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}