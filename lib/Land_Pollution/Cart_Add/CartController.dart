import 'package:get/get.dart';
class CartController extends GetxController{

  var Total = 0.obs;
  void increment(int price) => Total.value+=price;
  void decrement(int price) => Total.value-=price;
}
