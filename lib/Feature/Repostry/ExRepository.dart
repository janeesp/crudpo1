import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudpo1/Model_Page/Model.dart';
import 'package:crudpo1/constant/Firebasecollection.dart';
import 'package:crudpo1/core/Firebase_Provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final ExamoleRepositoryProvider= Provider((ref) => ExamoleRepository(firebaseFirestore: ref.read(firestoreProvider)));
class ExamoleRepository{
  final FirebaseFirestore _firebaseFirestore;
  ExamoleRepository({
    required FirebaseFirestore firebaseFirestore
}):
      _firebaseFirestore =firebaseFirestore;
  addItems(ItemModel itemModel){
    _firebaseFirestore.collection(FirebaseConst.firebaseColloction).add(itemModel.toJson()).then((value) =>
        value.update({"id":value.id}));
  }
 Stream<List<ItemModel>> getItems(){
  return  _firebaseFirestore.collection(FirebaseConst.firebaseColloction).snapshots().map((event) =>
      event.docs.map((e) => ItemModel.fromJson(e.data())).toList() );
  }
updateItems(ItemModel itemModel, String,newname,newemail,newplace,newpassword){
    ItemModel a=itemModel.copyWith(
      name: newname,email: newemail,password: newpassword,place: newplace
    );
    return _firebaseFirestore.collection(FirebaseConst.firebaseColloction).doc(itemModel.id).update(
     a.toJson()
    );
}
deleteItems(ItemModel itemModel){
    _firebaseFirestore.collection(FirebaseConst.firebaseColloction).doc(itemModel.id).delete();

}
}
