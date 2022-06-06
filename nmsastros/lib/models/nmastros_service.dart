import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/nmsastros.dart';

class NmsastrosService {
  //obtendo uma instância do Firebase localmente
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //método para gravar dados no Firebase
  add(Nmsastros nmsastros) {
    _firestore.collection("nmsastros").add(
          nmsastros
              .toMap(), //toMap faz a conversão do objeto em um MAP para ser persistido
          //no Firebase, enviamos dados em formato Json.
        );
  }

  //Criar método para obter os dados do FIREBASE
  //Devemos definir o tipo de retorno de acordo com quem vai receber o resultado
  getNmsastrosList() {
    //definimos que tipo de dados pode conter a listagem vindo do firebase
    CollectionReference nmsastrosCollection =
        _firestore.collection('nmsastros');
    return nmsastrosCollection.snapshots();
  }
}
