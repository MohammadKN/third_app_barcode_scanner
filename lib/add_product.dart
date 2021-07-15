import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:third_app_barcode_scanner/edit_info.dart';
import 'package:flutter/material.dart';
import 'main.dart';


final nameCont = TextEditingController(),
    packageBuyingPriceCont = TextEditingController(),
    pieceSellingPriceCont = TextEditingController(),
    barcodeCont = TextEditingController(),
    packageCont = TextEditingController(),
    pieceCont = TextEditingController(),
    piecesLeftCont = TextEditingController();

late int piecesLeftCount;


class StlessAddProduct extends StatelessWidget {
  const StlessAddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddProduct();
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final ref = fb.reference().child('Products');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenHW = (screenWidth * screenHeight) / 200;
    double widthBlock = screenWidth / 100;
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  controller: nameCont,
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
                  controller: packageCont,
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
                  controller: pieceCont,
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
                  controller: piecesLeftCont,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Current Pieces Count (Optional)',
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
                  controller: packageBuyingPriceCont,
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
                  controller: pieceSellingPriceCont,
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
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.012),
                onPressed: () {
                  getBarcode();
                },
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      CupertinoIcons.barcode,
                      size: ((screenHeight + screenWidth) / 2) *
                          0.045,
                    ),
                    Text(
                      'Scan The Barcode',
                      style: TextStyle(
                          fontSize:
                          ((screenHeight + screenWidth) / 2) *
                              0.019),
                    ),
                  ],
                )
              ),
              NeumorphicButton(
                onPressed: (){},
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04),
                child: TextField(
                  controller: barcodeCont,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xaa000000),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    hintText: 'Or Enter The Barcode Manually',
                    border: InputBorder.none,
                  ),
                ),
              ),
              NeumorphicButton(
                margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.05),
                provideHapticFeedback: true,
                onPressed: () {
                  if (nameCont.text.isNotEmpty &&
                      packageCont.text.isNotEmpty &&
                      pieceCont.text.isNotEmpty &&
                      packageBuyingPriceCont.text.isNotEmpty &&
                      pieceSellingPriceCont.text.isNotEmpty &&
                      barcodeCont.text.isNotEmpty) {
                    setState(() {
                      if (piecesLeftCont.text.isEmpty) {
                        piecesLeftCount = int.parse(packageCont.text) *
                            int.parse(pieceCont.text);
                      }
                      else if (piecesLeftCont.text.isNotEmpty){
                        piecesLeftCount = int.parse(piecesLeftCont.text);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Adding')));
                      ref
                          .child('Product: ${barcodeCont.text}')
                          .set({
                        'Barcode': barcodeCont.text,
                        'Name': nameCont.text,
                        'Package Count': packageCont.text,
                        'Pieces Per Package': pieceCont.text,
                        'Package Buying Price':
                        packageBuyingPriceCont.text,
                        'Piece Selling Price':
                        pieceSellingPriceCont.text,
                        'Pieces Left': piecesLeftCount,
                        'Profit Per Piece': profitPerPiece(),
                        'Profit Per Package': profitPerPackage(),
                      }).then((_) {
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=> HomePage()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text('Successfully Added')));
                        nameCont.clear();
                        packageCont.clear();
                        pieceCont.clear();
                        piecesLeftCont.clear();
                        packageBuyingPriceCont.clear();
                        pieceSellingPriceCont.clear();
                        barcodeCont.clear();
                      }).catchError((onError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(onError)));
                      });
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg:
                      "Please Make Sure To Fill All The Fields",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                    );
                  }
                },
                child: SizedBox(
                  width: screenWidth * 0.70,
                  height: screenHeight * 0.06,
                  child: Center(
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                          fontSize:
                          (screenHeight + screenWidth) / 2 * 0.05,
                          color: Colors.black54,
                        ),
                      )),
                ),
              ),
              Container(
                width: screenWidth,
                height: screenHeight/10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff2222", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanResult = 'failed';
    }
    if (!mounted) return;
    setState(() {
      print(scanResult.toString());
      barcodeCont.text = scanResult.toString();
    });
  }
}
