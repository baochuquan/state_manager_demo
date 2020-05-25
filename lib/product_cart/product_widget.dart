import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:statemanagerdemo/product_cart/product.dart';
import 'package:statemanagerdemo/product_cart/utils.dart';

class ProductSquare extends StatelessWidget {
  final Product product;

  final GestureTapCallback onTap;

  ProductSquare({
    Key key,
    @required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: product.color,
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: Text(
              product.name,
              style: TextStyle(
                  color: isDark(product.color) ? Colors.white : Colors.black),
            )),
      ),
    );
  }
}
