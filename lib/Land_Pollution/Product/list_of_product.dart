import 'package:environment_app/Land_Pollution/Product/project_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class CoffeeCard extends StatelessWidget {
  final String Categorie;

  const CoffeeCard({
    Key? key,
    required this.Categorie,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    print("Categorie is " + this.Categorie);
    return  Container( //Flexible

        child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('product').where("Categorie" ,isEqualTo: Categorie).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                final int count = (snapshot.data as QuerySnapshot<Object>).size;
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
                      final DocumentSnapshot document = (snapshot.data as QuerySnapshot<Object>).docs[index];
                      print((document.data() as Map<String, dynamic>)['Image']?.toString() ?? '');
                      print((document.data() as Map<String, dynamic>)['Name']?.toString() ?? '');
                      print((document.data() as Map<String, dynamic>)['Price']?.toString() ?? '');
                      print((document.data() as Map<String, dynamic>)['Categorie']?.toString() ?? '');
                      print((document.data() as Map<String, dynamic>)['desc']?.toString() ?? '');
                      print((document.data() as Map<String, dynamic>)['short_desc']?.toString() ?? '');
                      print(document.id);
                      return Column(
                        children: [
                          Container(
                            height: 250,
                            width: 160,
                            child: InkWell(

                               onTap: (){
                                 String id = document.id;
                                 Navigator.of(context).push(
                                     MaterialPageRoute
                                       (builder: (context) => thumb( id)),);
                                 // Navigator.of(context)
                                 //     .pushNamed(CoffeeDetailsPage.routeName, arguments: id);
                          },
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
                                        // add placeholder so that in case image is not load then some message can be seen by customer
                                          image: NetworkImage((document.data() as Map<String, dynamic>)['Image']?.toString() ?? ''),
                                          fit: BoxFit.cover)),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                      (document.data() as Map<String, dynamic>)['Name']?.toString() ?? 'not found',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        (document.data() as Map<String, dynamic>)['short_desc']?.toString() ?? 'not found',
                                        style: TextStyle(
                                            color: Color(0xff919293),
                                            fontSize: 11),
                                        overflow: TextOverflow.ellipsis,
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
                                                    color: Colors.green[400],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "${(document.data() as Map<String, dynamic>)['Price']?.toString() ?? '0'}",
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
                                                  color: Colors.green[400],
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
                            ),),
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
    );
}
}


