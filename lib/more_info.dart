import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:third_app_barcode_scanner/edit_info.dart';
import 'main.dart';

Color darkColor = Colors.black87;
Color brightColor = Colors.black54;
class stlessMore extends StatelessWidget {
  const stlessMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoreInfo();
  }
}

class MoreInfo extends StatefulWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenHW = (screenWidth * screenHeight) / 200;
    double widthBlock = screenWidth / 100;
    print(screenHW);
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              NeumorphicButton(
                onPressed: (){},
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Name',
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: brightColor,
                        ),
                      ),
                      trailing: Text(lists[Index]["Name"],
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: darkColor,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Package Count',
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: brightColor,
                        ),
                      ),
                      trailing: Text(lists[Index]["Package Count"],
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: darkColor,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Pieces Per Package',
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: brightColor,
                        ),
                      ),
                      trailing: Text(lists[Index]["Pieces Per Package"],
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: darkColor,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Pieces Left',
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: brightColor,
                        ),
                      ),
                      trailing: Text(lists[Index]["Pieces Left"].toString(),
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: darkColor,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Package Buying Price',
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: brightColor,
                        ),
                      ),
                      trailing: Text(lists[Index]["Package Buying Price"],
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: darkColor,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Piece Selling Price',
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: brightColor,
                        ),
                      ),
                      trailing: Text(lists[Index]["Piece Selling Price"],
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: darkColor,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Barcode',
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: brightColor,
                        ),
                      ),
                      trailing: Text(lists[Index]["Barcode"],
                        style: TextStyle(
                          fontSize: screenHW/76,
                          color: darkColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              NeumorphicButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditInfo()));
                },
                child: SizedBox(
                  width: screenWidth * 0.70,
                  height: screenHeight * 0.06,
                  child: Center(
                    child: Text(
                      'Edit Info',
                      style: TextStyle(
                        fontSize:
                        (screenHeight + screenWidth) / 2 * 0.05,
                        color: Colors.black54,
                      ),
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}