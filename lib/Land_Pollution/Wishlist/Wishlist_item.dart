import 'package:flutter/material.dart';
import 'package:environment_app/Land_Pollution/Wishlist//boxes.dart';
import '../models/product_model.dart';

class wishItem extends StatefulWidget {
  const wishItem({Key? key }) : super(key: key);
  @override
  _wishItemState createState() => _wishItemState();
}
class _wishItemState extends State<wishItem>{

  Widget build(BuildContext context) {

    final box = Boxes.getTransactions();
    List<Product>item = box.values.toList();
     var count = item.length;

    return Scaffold(
        appBar: AppBar(
        title: Text('WishList'),
    backgroundColor: Colors.green,
    ),
      body:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //number of columns
          childAspectRatio: 0.6, // aspect ratio of the grid cells
          crossAxisSpacing: 20, // horizontal spacing between cells
          mainAxisSpacing: 0, // vertical spacing between cells
        ),

        shrinkWrap: true,
        itemCount: count,
         itemBuilder: ( context,  index) {

          String name = item[index].Name;
          String imageurl = item[index].ImageUrl;
          String short_desc = item[index].Short_Desc;
          String desc = item[index].Desc;
          String size = item[index].Size;

          return Column(
             children: [
               Container(
                 height: 250,
                 width: 160,
                 child: InkWell(

                   // onTap: (){
                   //   // String id = document.id;
                   //   Navigator.of(context).push(
                   //     MaterialPageRoute
                   //       (builder: (context) => thumb( id)),);
                   //   // Navigator.of(context)
                   //   //     .pushNamed(CoffeeDetailsPage.routeName, arguments: id);
                   // },
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
                                 image: NetworkImage(imageurl),
                                 fit: BoxFit.cover)),
                       ),

                       Padding(
                         padding: EdgeInsets.all(15),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment
                               .start,
                           children: [
                             Text(
                               name,
                               style: TextStyle(color: Colors.black),
                             ),
                             SizedBox(
                               height: 3,
                             ),
                             Text(
                               short_desc,
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
                                 // Row(
                                 //   children: [
                                 //     Text(
                                 //       r'Rs. ',
                                 //       style: TextStyle(
                                 //           color: Colors.green[400],
                                 //           fontWeight: FontWeight.bold,
                                 //           fontSize: 20),
                                 //     ),
                                 //     Text(
                                 //       // "${(document.data() as Map<String, dynamic>)['Price']?.toString() ?? '0'}",
                                 //       "${box.get('Price')}",
                                 //       style: TextStyle(
                                 //           color: Colors.black,
                                 //           fontSize: 20,
                                 //           fontWeight: FontWeight
                                 //               .bold),
                                 //     )
                                 //   ],
                                 // ),
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
                                     )
                                 )
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
         },
    )
    );
  }
}