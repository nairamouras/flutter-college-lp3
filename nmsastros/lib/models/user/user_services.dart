import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/user/user_local.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection("user");

class UserServices extends ChangeNotifier {
  UserLocal? userLocal;

  List<UserLocal> allUser = [];
  //método construtor
  UserServices() {
    _loadingCurrentUser();
    _loadAllUser();
  }

  Future<void> signIn(
    UserLocal userLocal, {
    Function? onSucess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: userLocal.email!, password: userLocal.password!))
          .user;
      this.userLocal = userLocal;
      this.userLocal!.id = user!.uid;
      // await _loadingCurrentUser(user: user);
      onSucess!();
    } on PlatformException catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  Future<void> signUp(
    UserLocal userLocal, {
    Function? onSucess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: userLocal.email!, password: userLocal.password!))
          .user;
      userLocal.id = user?.uid;
      this.userLocal = userLocal;
      await userLocal.saveData();
      onSucess!();
    } catch (e) {
      onFail!(debugPrint(e.toString()));
    }
    notifyListeners();
  }

  Future<void> _loadingCurrentUser({User? user}) async {
    final User? currentUser = user ?? _auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await _firestore.collection("user").doc(currentUser.uid).get();

      userLocal = UserLocal.fromDocument(docUser);

      notifyListeners();
    }
  }

  Stream<QuerySnapshot> getUser() {
    return _collectionReference.snapshots();
  }

  Future<void> _loadAllUser() async {
    _firestore.collection("user").snapshots().listen((snap) {
      allUser = snap.docs.map((e) => UserLocal.fromDocument(e)).toList();
    });
  }
}
