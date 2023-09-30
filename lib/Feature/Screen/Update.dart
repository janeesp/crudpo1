
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model_Page/Model.dart';
import '../Controller/ExController.dart';

class UpdatePage extends ConsumerStatefulWidget {
  ItemModel data;
   UpdatePage(  {super.key,required this.data});


  @override
  ConsumerState createState() => _UpdateState();
}

class _UpdateState extends ConsumerState<UpdatePage> {
  RegExp Emailvalidator=RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)");
  RegExp Passwordvalidator=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[./@!&%$#]).{8,}$');
  TextEditingController ?name_controler ;
  TextEditingController ?place_controler ;
  TextEditingController ?Email_controler ;
  TextEditingController? password_controler ;
  addItems(){
    ref.read(ExmplControlerProvider).addItems(
      ItemModel(name: name_controler!.text,
          place: place_controler!.text,
          email: Email_controler!.text,
          password: password_controler!.text,
          id: '',
          image: ''),

    );
  }

  updateItems(){
    ref.watch(ExmplControlerProvider).updateItems(widget.data ,name_controler!.text,
        Email_controler!.text,
        place_controler!.text,
        password_controler!.text,
        imageUrl.toString()
    );
  }
  String imageUrl="";
  late XFile photo;
  final  imagePicker=ImagePicker();
  File? image;

  Future getImage() async {
    var picImage= await imagePicker.pickImage(source:ImageSource.gallery );
    setState(() {
      if(picImage !=null){
        image= File(picImage.path);
      }else{
        print("No image Select");
      }
    });
  }
  Future uplodImage() async {
    getImage();
    String uniqueFileName=DateTime.now().microsecondsSinceEpoch.toString();
    Reference rute=FirebaseStorage.instance.ref();
    Reference referenceRuteDirect=rute.child("image");
    Reference referenceuplodImage=referenceRuteDirect.child(uniqueFileName);
    await referenceuplodImage.putFile(File(image!.path));
    var downlodUrl=await referenceuplodImage.getDownloadURL();
    imageUrl=downlodUrl;
    setState(() {

    });
    return ;
  }


  //  Future<FilePickerResult?>
  // pickImage() async {
  //
  //   final image = await FilePicker.platform.pickFiles(type: FileType.image);
  //   return image;
  // }
  // FutureEither<String> storeFile(
  //     {required String path, required String id, required File? file}) async {
  //   try {
  //     final ref = _firebaseStorage.ref().child(path).child(id +DateTime.now().toString());
  //     final uploadSnapshot = await ref.putFile(file!);
  //     final snapshot = uploadSnapshot;
  //
  //     return right(await snapshot.ref.getDownloadURL());
  //   } on FirebaseException catch (e) {
  //     throw e.message!;
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    name_controler=TextEditingController(text:widget.data.name);
    Email_controler=TextEditingController(text: widget.data.email);
    place_controler=TextEditingController(text: widget.data.place);
    password_controler=TextEditingController(text: widget.data.password);
    // imageUrl=widget.data.image.toString();


    super.initState();
  }

  bool eye =false;
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
              child: CircleAvatar(
                radius: width*0.2,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(
              height: width*0.2,
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
                  // if(name_controler.text.isNotEmpty&&place_controler.text.isNotEmpty&&Email_controler.text.isNotEmpty
                  //     &&password_controler.text.isNotEmpty){
                    updateItems();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("submitted successfully")));
                    Navigator.pop(context);
                  // }
                  // else{
                    // name_controler.text.isEmpty?
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter name"))):
                    // place_controler.text.isEmpty?
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter place"))):
                    // Email_controler.text.isEmpty?
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter Email"))):
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter password")));
                  // }


                }, child: Text("Update"))
          ],
        ),
      ),
    ),
    );


  }
}
