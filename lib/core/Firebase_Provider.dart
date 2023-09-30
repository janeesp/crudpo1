import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudpo1/Model_Page/Model.dart';
import 'package:crudpo1/constant/Firebasecollection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider=Provider((ref) => FirebaseFirestore.instance);


// final getFirebaseProvider = StreamProvider((ref)  {
//   print('0000..');
//
//   return FirebaseFirestore.instance.collection(FirebaseConst.firebaseColloction).snapshots().map((event) =>
//       event.docs.map((e) =>ItemModel.fromMap(e.data())).toList());
//
//
// });