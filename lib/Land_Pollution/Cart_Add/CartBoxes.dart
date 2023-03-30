import 'package:hive/hive.dart';
import 'package:environment_app/Land_Pollution/models/product_model.dart';

class cart_Item {
  static Box<Product> getCart() =>
      Hive.box<Product>('cart');
}