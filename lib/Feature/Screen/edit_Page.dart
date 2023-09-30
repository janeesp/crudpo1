import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudpo1/Feature/Controller/ExController.dart';
import 'package:crudpo1/Model_Page/Model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends ConsumerStatefulWidget {
  const EditPage({super.key});

  @override
  ConsumerState createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  RegExp Emailvalidator=RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)");
  RegExp Passwordvalidator=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[./@!&%$#]).{8,}$');
  TextEditingController name_controler = TextEditingController();
  TextEditingController place_controler = TextEditingController();
  TextEditingController Email_controler = TextEditingController();
  TextEditingController password_controler = TextEditingController();
  addItems(){
ref.read(ExmplControlerProvider).addItems(
  ItemModel(name: name_controler.text,
      place: place_controler.text,
      password: password_controler.text,
      email: Email_controler.text,
      image:imageUrl,
      id: ''),

);
  }
 String imageUrl="";
   late XFile photo;

    File ?image;
   final imagePicker=ImagePicker();

Future getImage() async {
   var  picImage= await imagePicker.pickImage(source: ImageSource.gallery);
   setState(() {
     if(picImage != null){
       image=File(picImage.path);
     }else{
       print("No image selected");
     }
   });
 }
Future uplodImage() async {
  getImage();
  String uniqueFileName=DateTime.now().microsecondsSinceEpoch.toString();
  Reference rute=FirebaseStorage.instance.ref();
  Reference referenceRuteDir=rute.child("image");
  Reference referenceUplodImage=referenceRuteDir.child(uniqueFileName);
 await referenceUplodImage.putFile(File(image!.path));
  var downloadUrl =await referenceUplodImage.getDownloadURL();
  imageUrl=downloadUrl;
  setState(() {

  });
  return ;

}

  bool eye=false;
  @override
  Widget build(BuildContext context) {
  var width =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  uplodImage();
                },
                child: Container(
                  height: width*0.4,
                  width: width*0.7,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(imageUrl)),
                    color: Colors.grey,
                    boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.2),
                         spreadRadius:2,
                         blurRadius: 4,
                         offset: Offset(0, 2)
                       ),
                    ]

                  ),

                ),
              ),
              SizedBox(
                height: width*0.04,
              ),
              TextFormField(
                controller: name_controler,
                decoration: InputDecoration(
                    hintText:" Name:",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              ),SizedBox(
                height: width*0.03,
              ),
              TextFormField(
                controller: place_controler,
                decoration: InputDecoration(
                    hintText:" Place:",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              ),
              SizedBox(
                height: width*0.03,
              ),
              TextFormField(
                controller: Email_controler,
                decoration: InputDecoration(
                    hintText:" Email:",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if(!Emailvalidator.hasMatch(value!)){
                    return "Ener currect Email";
                  }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(
                height: width*0.03,
              ),
              TextFormField(
                controller:password_controler ,
                maxLength: 8,
                obscureText: eye==true?false:true,
                decoration: InputDecoration(
                    hintText:" Password:",
                    suffixIcon: InkWell(
                      onTap:() {
                        eye=!eye;
                        setState(() {

                        });
                      },
                        child:eye ==true? Icon(Icons.remove_red_eye_outlined):Icon(Icons.visibility_off)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
                autovalidateMode:AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if(!Passwordvalidator.hasMatch(value!)){
                    return "enter currect Password";
                  }
                  else{
                    return null ;
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if(name_controler.text.isNotEmpty&&place_controler.text.isNotEmpty&&Email_controler.text.isNotEmpty
                        &&password_controler.text.isNotEmpty){

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("submitted successfully")));
                      addItems();
                      Navigator.pop(context);
                    }  else{
                      name_controler.text.isEmpty?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter name"))):
                      place_controler.text.isEmpty?
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter place"))):
                          Email_controler.text.isEmpty?
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter Email"))):
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter password")));
                    }


              }, child: Text("add"))
            ],
          ),
        ),
      ),
    );
  }
}
