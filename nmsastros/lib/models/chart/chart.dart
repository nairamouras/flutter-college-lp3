import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Chart {
  String? id;
  String? name;
  String? preco;

  //método construtor
  Chart({
    this.id,
    required this.name,
    required this.preco,
  });

  Chart.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    preco = document['preco'] as String;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'preco': preco,
    };
  }

  factory Chart.fromMap(Map<String, dynamic> map) {
    return Chart(
      id: map['id'] as String,
      name: map['name'] as String,
      preco: map['preco'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chart.fromJson(String source) => Chart.fromMap(json.decode(source));

  @override
  String toString() => 'Chart(id: $id, name: $name, preco: $preco)';
}
