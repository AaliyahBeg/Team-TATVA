class DataSet {
  DataSet({required this.Name, required this.Image, required this.Price, required this.Short_desc, required this.Desc, required this.Categorie});

  DataSet.fromJson(Map<String, Object?> json)
      : this(
    Name: json['Name']! as String,
   Image: json['Image']! as String,
    Price: json['Price']! as String,
    Short_desc: json['Short_desc']! as String,
    Desc: json['Desc']! as String,
    Categorie: json['Categorie']! as String,
  );

  final String Name;
  final String Image;
  final String Price;
  final String Short_desc;
  final String Desc;
  final String Categorie;

  Map<String, Object?> toJson() {
    return {
      'Name': Name,
      'Image': Image,
      'Price': Price,
      'Short_desc': Short_desc,
      'Desc': Desc,
      'Categorie': Categorie,
    };
  }
}
// final moviesRef = FirebaseFirestore.instance.collection('dataset').withConverter<DataSet>(
//   fromFirestore: (snapshot, _) => DataSet.fromJson(snapshot.data()!),
//   toFirestore: (dataset, _) => dataset.toJson(),
// );