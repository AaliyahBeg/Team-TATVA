import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String Name;
  @HiveField(2)
  final String Category;
  @HiveField(3)
  final double Price ;
  @HiveField(4)
  final String Size;
  @HiveField(5)
  final String Desc;
  @HiveField(6)
  final String Short_Desc;
  @HiveField(7)
  final String ImageUrl;

  const Product ({
    required this.id,
    required this.Name,
    required this.Category,
    required this.Size,
    required this.Price,
    required this.Desc,
    required this.Short_Desc,
    required this.ImageUrl,
});

  static Product fromSnapshot(DocumentSnapshot snap){
    Product product = Product(
      id: snap.id,
      Name: snap['name'],
      Category: snap['category'],
      Price: snap['price'],
      Size: snap['size'],
      Desc: snap['desc'],
      Short_Desc: snap['short_desc'],
      ImageUrl: snap['imageUrl'],
    );
    return product;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    Name ,
    Category,
    Price ,
    Size ,
    Desc,
    Short_Desc ,
    ImageUrl,
  ];

}