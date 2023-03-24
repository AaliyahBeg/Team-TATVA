import 'package:hive_flutter/hive_flutter.dart';
import '../models/product_model.dart';
abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<Product> getWishlist(Box  box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductToWishlist(Box box, Product product);
  Future<void> clearProductToWishlist(Box box);
}