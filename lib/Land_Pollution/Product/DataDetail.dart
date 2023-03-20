class DataSet {
  DataSet({required this.Name, required this.Image, required this.Price, required this.short_desc, required this.desc, required this.Categorie , required this.size});

  DataSet.fromJson(Map<String, Object?> json)
      : this(
    Name: json['Name']! as String,
   Image: json['Image']! as String,
    Price: json['Price']! as String,
    short_desc: json['short_desc']! as String,
    desc: json['desc']! as String,
    Categorie: json['Categorie']! as String,
    size :json['size']! as String,
  );

  final String Name;
  final String Image;
  final String Price;
  final String short_desc;
  final String desc;
  final String Categorie;
  final String size;
  Map<String, Object?> toJson() {
    return {
      'Name': Name,
      'Image': Image,
      'Price': Price,
      'Short_desc': short_desc,
      'Desc': desc,
      'Categorie': Categorie,
      'size': size,
    };
  }
}
// final moviesRef = FirebaseFirestore.instance.collection('dataset').withConverter<DataSet>(
//   fromFirestore: (snapshot, _) => DataSet.fromJson(snapshot.data()!),
//   toFirestore: (dataset, _) => dataset.toJson(),
// );