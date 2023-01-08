import 'dart:core';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class CardItem{
  final String urlImage;
  final String title;
  final String desc;
  const CardItem({
    required this.urlImage,
    required this.title,
    required this.desc,
  });
}

class _HomeState extends State<Home> {
  List<CardItem> items =[
    CardItem(
      urlImage: 'https://4.bp.blogspot.com/-N_WdeyPGz10/TocPGEkD1YI/AAAAAAAAAGU/h8Abdw5Ukdw/s1600/Soil+pollution2.jpg',
      title:"LAND POLLUTION",
      desc: "",
    ),
    CardItem(
      urlImage:'https://th.bing.com/th/id/OIP.L2Q2NieXVo4DQbkHnNOTQgHaE8?pid=ImgDet&rs=1' ,
      title:"WATER POLLUTION",
      desc: "",
    ),
    CardItem(
      urlImage: 'https://hhp-blog.s3.amazonaws.com/2020/07/GettyImages-1098018152.jpg',
      title:"AIR POLLUTION",
      desc: "",
    ),
    CardItem(
      urlImage: 'https://buzznigeria.com/wp-content/uploads/2016/06/noise-pollution.jpg',
      title:"NOISE POLLUTION",
      desc: "",
    ),
    CardItem(
      urlImage: 'https://th.bing.com/th/id/R.a9eb12ffaa1b41e866e0201c4ab8ec0e?rik=TdI6r%2b9Fv%2bT7Wg&riu=http%3a%2f%2f3.bp.blogspot.com%2f-LAxx2eW-LxM%2fVpugCSfkuxI%2fAAAAAAAABJQ%2fwA0P-9iSi9c%2fs1600%2fstreet-light.jpg&ehk=fuBrNPLvM5PWNh2PWc1SbIkYhclbBB%2fnofgJ%2fsM5tms%3d&risl=&pid=ImgRaw&r=0',
      title:"LIGHT POLLUTION",
      desc: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text('NATURALEZA',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )
            ),
            leading: Icon(Icons.energy_savings_leaf_rounded, color: Colors.black, size: 35,),
            actions: [
              Icon(Icons.search, color: Colors.black, size: 30,),
              SizedBox(width: 15),
            ]
        ),
        body:
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                    child: Text(
                        'Home',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  )
              ),

              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.3, 0.75, 0.9],
                          colors: [
                            const Color(0xFF3DA35D),
                            const Color(0xFF96E072),
                            const Color(0xFFE8FCCF),
                          ]
                      ),
                    ),
                    child: Text('Petitions',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )
              ),
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                      child: Text('Connect',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          )))
              ),
              GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '')},
                  child: Container(
                      child: Text('News',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          )))
              ),
            ],
          ),
          SizedBox(height:12),
          // SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child:Row(
          //       children: [
          //         buildCard(),
          //         SizedBox(width:12),
          //         buildCard(),
          //         SizedBox(width:12),
          //         buildCard(),
          //         SizedBox(width:12),
          //         buildCard(),
          //         SizedBox(width:12),
          //         buildCard(),
          //
          //       ],
          //     )
          //
          // ),

          Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                SizedBox(height:20),
                Text(
                  "CONTROL",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                ),
                Container(
                  height: 256,
                  child: ScrollSnapList(
                    padding: EdgeInsets.fromLTRB(16,12,16,12),
                    scrollDirection: Axis.horizontal,
                      onItemFocus:(int){

                      },
                      itemSize: 200,
                      dynamicItemSize: true,
                      // itemBuilder: (context,_)=> SizedBox(width:12),
                      itemBuilder: (context,index) => buildCard(item:items[index]),
                      itemCount: 7,
                  ),

                ),
              ],
            ),
          )


        ]
    )
    ),

    );
  }
  Widget buildCard({
  required CardItem item,
}) => Container(
    width: 200,
    child: Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 4/3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                item.urlImage,
                fit:BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          item.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

        ),
        Text(
          item.desc,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w100,
            color: Colors.grey,
          ),
        ),
       Container(

         child:getWidget(item.title),

       ),


      ],
    ),
  );
  Widget getWidget(String title){
    if(title=='LAND POLLUTION')
      return Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

          ],
        ),
    );
    else if(title=='WATER POLLUTION')
      return Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

          ],
        ),
      );
    else if(title=='AIR POLLUTION')
      return Container(
        child:Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            Text(
              "AQI GRAPHS",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),

          ],
        ),
      );
    else if(title=='NOISE POLLUTION')
      return Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

          ],
        ),
      );
    else if(title=='LIGHT POLLUTION')
    return Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

        ],
      ),
    );
    else return Container(

      );
  }
}

