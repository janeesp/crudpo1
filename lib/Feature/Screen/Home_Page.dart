

import 'dart:collection';

import 'package:crudpo1/Feature/Controller/ExController.dart';
import 'package:crudpo1/Feature/Screen/Update.dart';
import 'package:crudpo1/constant/Firebasecollection.dart';
import 'package:crudpo1/core/Firebase_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model_Page/Model.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              print('Details');

              deleteItems(ItemModel itemModel){
                ref.watch(ExmplControlerProvider).deleteItems(itemModel);
              }

              return  ref.watch(getFirebaseProvider)
             .when(data: (data) {
                print('datataaaaa');


                return     Expanded(
               child: ListView.builder(
                   scrollDirection: Axis.vertical,
                   // physics: NeverScrollableScrollPhysics(),
                   padding: EdgeInsets.all(8.0),
                   itemCount: data.length,
                   shrinkWrap: true,
                   itemBuilder:(context, index) {
                   ItemModel Details =data[index];
                   print(Details);
                     return
                       Container(
                         padding: EdgeInsets.all(8.0),
                         margin: EdgeInsets.only(bottom: width*0.02),
                         height: width*0.4,
                         width: width*0.8,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10),
                             boxShadow: [
                               BoxShadow(color: Colors.black,
                                   offset: Offset(0, 2),
                                   blurRadius: 4,
                                   spreadRadius: 2)
                             ]
                         ),
                         child:
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [

                             Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 CircleAvatar(
                                   radius: width*0.05,
                                   backgroundImage:NetworkImage(Details.image) ,

                                 ),
                                 Text(Details.name.toString()??"",style: TextStyle(fontSize: 20),),
                                 Text(Details.place.toString()??"",style: TextStyle(fontSize: 20),),
                                 Text(Details.password.toString()??"",style: TextStyle(fontSize: 20),),
                                 Text(Details.email.toString()??"",style: TextStyle(fontSize: 20),)
                               ],
                             ),
                           Row(
                             children: [
                               IconButton(
                                   onPressed: () {

                                   }, icon:InkWell(
                                 onTap: () {
                                   showDialog(
                                     context: context,
                                     builder: (context) => AlertDialog(
                                      title: Text("you want to delete"),
                                       content: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           InkWell(
                                             onTap: () {
                                               deleteItems(data[index]);
                                               Navigator.pop(context);

                                             },
                                             child:
                                             Container(
                                               height: width*0.1,
                                               width: width*0.2,
                                               color: Colors.redAccent,
                                               child: Center(child: Text("Yes",style:
                                               TextStyle(fontWeight: FontWeight.w700),)),
                                             ),
                                           ),
                                           SizedBox(
                                             width: width*0.1,
                                           ),
                                           InkWell(
                                             onTap:() {
                                               Navigator.pop(context);
                                             },
                                             child: Container(
                                               height: width*0.1,
                                               width: width*0.2,
                                               color: Colors.redAccent,
                                               child: Center(child: Text("No",style: TextStyle(fontWeight: FontWeight.w700))),
                                             ),
                                           )
                                         ],
                                       ),
                                     ),);
                                 },
                                 child: Container(
                                     color: Colors.blue,
                                     child: Icon(Icons.delete)),
                               )),
                               IconButton(
                                   onPressed:() {
                                     // Navigator.pushNamed(context, '/add');
                                     Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                         UpdatePage(data: data[index],)));

                                   },  icon: Container(
                                   color: Colors.blue,
                                   child: Icon(Icons.edit)))
                             ],
                           )

                           ],
                         ),

                       );
                   },
                  ),
             );

             },
                 error: (error, stackTrace) {
                   print(error.toString());
                   print(stackTrace.toString());
                   return Text("");
                 },
                 loading: () => CircularProgressIndicator(),);
            },

          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
  Navigator.pushNamed(context, '/add');
        },child: Icon(Icons.add),
      ),
    );
  }


}
