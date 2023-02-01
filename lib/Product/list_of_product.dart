import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Project_detail.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class CoffeeCard extends StatelessWidget {
  List<String> images = [
    "images/tyler-nix-nwdtkFzDfPY-unsplash.jpg",
    "images/newcappuccino.jpg",
    "images/newcoffee.jpg",
    "images/nicholas-grande-Hd36cpebWbQ-unsplash.jpg",
    "images/tyler-nix-nwdtkFzDfPY-unsplash.jpg",
    "images/newcappuccino.jpg",
    "images/newcoffee.jpg",
    "images/nicholas-grande-Hd36cpebWbQ-unsplash.jpg",
  ];

  List<String> ingredients = [
    "With Oat Milk",
    "With Cinnamon Powder",
    "With Chocolate Powder",
    "With Caramel Drizzle",
    "With Oat Milk",
    "With Cinnamon Powder",
    "With Chocolate Powder",
    "With Caramel Drizzle"
  ];

  List<String> product_name = [

  ];



  List<double> price = [4.29, 3.21, 6.46, 2.90,4.29, 3.21, 6.46, 2.90];

  @override
  Widget build(BuildContext context) {
    // FutureBuilder<DocumentSnapshot>(
    //   future: users.doc(documentId).get(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //
    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }
    //
    //     if (snapshot.hasData && !snapshot.data!.exists) {
    //       return Text("Document does not exist");
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    //       return Text("Full Name: ${data['full_name']} ${data['last_name']}");
    //     }
    //
    //     return Text("loading");
    //   },
    // );

    return  Flexible(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CoffeeDetailsPage()));
        },

        child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('collection_name').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                final int count = (snapshot.data as Map<String, dynamic>).length;
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //number of columns
                      childAspectRatio: 0.6, // aspect ratio of the grid cells
                      crossAxisSpacing: 20, // horizontal spacing between cells
                      mainAxisSpacing: 0, // vertical spacing between cells
                    ),
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot document = (snapshot.data.documents as Map<int,dynamic>).get(index);
                      return Column(
                        children: [
                          Container(
                            height: 250,
                            width: 160,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 135,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(images[index]),
                                          fit: BoxFit.cover)),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        product_name[index],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        ingredients[index],
                                        style: TextStyle(
                                            color: Color(0xff919293),
                                            fontSize: 11),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                r'Rs. ',
                                                style: TextStyle(
                                                    color: Color(0xffd17842),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "${price[index]}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              )
                                            ],
                                          ),
                                          Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffd17842),
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 20,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xF6F3F3E4),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      );
                    }
                );
            }
          }
      ),
    ),
    );
}
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();

}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('collection_name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return CircularProgressIndicator();
          default:
            return ListView(
              children: short(snapshot)
            );
        }
      },
    );

  }
}
short(snapshot){
   return snapshot.data.docs.map((DocumentSnapshot document) {
  },
  ).toList();
}
// title: Text((document.data() as Map<String, dynamic>)['title']?.toString() ?? ''),
// subtitle: Text((document.data() as Map<String, dynamic>)['subtitle']?.toString() ?? ''),

