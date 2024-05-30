import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShopAnimasyon extends StatelessWidget {
  const ShopAnimasyon({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period:const  Duration(seconds: 10),
      baseColor: Colors.blue,
      highlightColor: Colors.yellow,
      child:const  Text(
        'Yusuf Duman Shoping',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40.0,
          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }
}
