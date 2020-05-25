import 'package:flutter/material.dart';
import 'package:statemanagerdemo/product_cart/cart.dart';
import 'package:statemanagerdemo/product_cart/cart_item.dart';
import 'package:statemanagerdemo/product_cart/utils.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart";

  final Cart cart;

  CartPage(this.cart);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: cart.items.isEmpty
          ? Center(
          child: Text('空空如也~', style: Theme.of(context).textTheme.display1))
          : ListView(
          children:
          cart.items.map((item) => CartItemTile(item: item)).toList()),
    );
  }
}

class CartItemTile extends StatelessWidget {
  CartItemTile({this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        color: isDark(item.product.color) ? Colors.white : Colors.black);

    return Container(
      color: item.product.color,
      child: ListTile(
        title: Text(
          item.product.name,
          style: textStyle,
        ),
        trailing: CircleAvatar(
            backgroundColor: const Color(0x33FFFFFF),
            child: Text(item.count.toString(), style: textStyle)),
      ),
    );
  }
}
