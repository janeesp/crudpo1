import 'package:crudpo1/Feature/Repostry/ExRepository.dart';
import 'package:crudpo1/Model_Page/Model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/Firebase_Provider.dart';
final ExmplControlerProvider = Provider((ref) => ExmplControler(examoleRepository: ref.read(ExamoleRepositoryProvider)));
final getFirebaseProvider = StreamProvider((ref)  {
  print('0000..');
  final _controller=ExamoleRepository(firebaseFirestore: ref.read(firestoreProvider));
  return _controller.getItems();


});
class ExmplControler{
  ExamoleRepository _examoleRepository;

  ExmplControler({
    required ExamoleRepository examoleRepository
}):
      _examoleRepository=examoleRepository;
  addItems(ItemModel itemModel){

    _examoleRepository.addItems(itemModel);
  }
  Stream<List<ItemModel>>getItems(){

    return _examoleRepository.getItems();
  }
  updateItems(ItemModel itemModel ,newname,newemail,newplace,newpassword, String nweimageUrl){
    _examoleRepository.updateItems(itemModel, String, newname, newemail, newplace, newpassword);
  }
  deleteItems(ItemModel itemModel){
    _examoleRepository.deleteItems(itemModel);
  }
}
