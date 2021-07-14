import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:third_app_barcode_scanner/add_product.dart';
import 'package:third_app_barcode_scanner/edit_info.dart';
import 'package:third_app_barcode_scanner/product_info.dart';
import 'more_info.dart';


final fb = FirebaseDatabase.instance;


late final Ref;

List<Map<dynamic, dynamic>> lists = [];

int Index = 0;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => AddProduct()));
          },
          child: Icon(Icons.add,color: Colors.white,),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: screenHeight/15,
            width: screenWidth,
            color: Color(0xffeeeeee),
            child: Neumorphic(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder(
                    future: ref.once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      return Container(
                        width: screenWidth / 6,
                        child: IconButton(
                          icon: Icon(
                              CupertinoIcons.list_bullet
                          ),
                          onPressed: () {
                            if (snapshot.hasData) {
                              lists.clear();
                              Map<dynamic, dynamic> values =
                                  snapshot.data!.value;
                              values.forEach((key, values) {
                                lists.add(values);
                              });
                              Navigator.push(context, CupertinoPageRoute(
                                  builder: (context) => AllProducts()));
                            }
                          },
                        ),
                      );
                    }
                  ),
                  Container(
                    width: screenWidth/6,
                    child: Icon(CupertinoIcons.list_bullet),
                  ),
                  Container(
                    width: screenWidth/6,
                  ),
                  Container(
                    width: screenWidth/6,
                  ),
                  Container(
                    width: screenWidth/6,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onLongPress: () async {
                  scanBarcode();
                },
                onDoubleTap: () async {
                  scanBarcodeContinuously();
                },
                child: NeumorphicButton(
                  //style: ButtonStyle(splashFactory: NoSplash.splashFactory,),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight / 2,
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Barcode Scanner',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widthBlock * 8,
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(15),
                      onPressed: () {},
                      child: Text('Scan Barcode'),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanBarcode() async {
    final ref = fb.reference().child('Products');
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanResult = 'Failed';
    }
    if (!mounted) return;
    setState(() {
      ref.child('Product: $scanResult').set({
        'Pieces Left': int.parse(lists[Index]["Pieces Left"])-1,
      });
    });
  }


  Future<void> scanBarcodeContinuously() async {
    String scanningResult;
    try {
      FlutterBarcodeScanner.getBarcodeStreamReceiver(
              "#ff6666", "Done", true, ScanMode.BARCODE)!
          .listen((barcode) async {
        setState(() {

        });
      });
    } on PlatformException {
      scanningResult = 'failed';
    }
    if (!mounted) return;
  }

  @override
  void dispose() {
    nameCont.dispose();
    packageCont.dispose();
    pieceCont.dispose();
    packageBuyingPriceCont.dispose();
    pieceSellingPriceCont.dispose();
    barcodeCont.dispose();
    super.dispose();
  }
}

String profitPerPiece() => (double.parse(pieceSellingPriceCont.text) -
        double.parse(packageBuyingPriceCont.text) /
            double.parse(pieceCont.text))
    .toStringAsFixed(2);

String profitPerPackage() =>
    (double.parse(pieceSellingPriceCont.text) * double.parse(pieceCont.text) -
            double.parse(packageBuyingPriceCont.text))
        .toStringAsFixed(2);