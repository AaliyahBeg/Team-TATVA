import 'package:hive/hive.dart';
import 'package:environment_app/Land_Pollution/models/product_model.dart';

class Boxes {
  static Box<Product> getTransactions() =>
      Hive.box<Product>('production');
}