
import 'package:statemanagerdemo/product_cart/product.dart';

class CartItem {
  final int count;
  final Product product;

  const CartItem(this.count, this.product);

  @override
  String toString() => "${product.name} x $count";
}