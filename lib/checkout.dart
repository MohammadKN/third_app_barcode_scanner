import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'main.dart';

List<Map<dynamic, dynamic>> checkoutList = [];

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  void initState() {
    checkout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = fb.reference().child('Products');
    return FutureBuilder(
        future: products.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            checkoutList.clear();
            Map<dynamic, dynamic> values = snapshot.data!.value;
            values.forEach((key, values) {
              checkoutList.add(values);
            });
            return ListView.builder(
              itemCount: checkoutList.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${checkoutList[index]}'),
                );
              },
            );
          }
          return RefreshProgressIndicator();
        });
  }
}

void checkout() {
  final products = fb.reference().child('Products');
  for (int i = currentArr.length; i >= 0; i--) {
    final product = products.child('Product: ${currentArr[i]}');
    product.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      products.child('Product: ${currentArr[i]}').update({
        'Pieces Left': values["Pieces Left"] - 1,
      });
    });
  }
}
