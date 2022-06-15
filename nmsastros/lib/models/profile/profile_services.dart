import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nmsastros/models/profile/profile.dart';

class ProfileServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("profile");

  //método para adicionar/gravar dados no firebase
  Future<DocumentReference> addProfile(Profile profile) {
    return _collectionReference.add(profile.toMap());
  }

//método utilizado para atualizar dados no firebase
  void updateProfile(Profile profile) async {
    await _collectionReference.doc(profile.id).set(profile.toMap());
  }

//método utilizado para deletar dados no firebase
  void deleteProfile(String id) async {
    await _collectionReference.doc(id).delete();
  }

  Stream<QuerySnapshot> getProfile() {
    return _collectionReference.snapshots();
  }
}
