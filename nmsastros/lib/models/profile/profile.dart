import 'dart:convert';
import 'package:flutter/material.dart';

class Profile {
  String? id;
  String name;
  String dateBirth;
  String localBirth;
  String timeBirth;

  //método construtor
  Profile({
    this.id,
    required this.name,
    required this.dateBirth,
    required this.localBirth,
    required this.timeBirth,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'dateBirth': dateBirth,
      'localBirth': localBirth,
      'timeBirth': timeBirth,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      name: map['name'] as String,
      dateBirth: map['dateBirth'] as String,
      localBirth: map['localBirth'] as String,
      timeBirth: map['timeBirth'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() =>
      'Profile(id: $id, name: $name, dateBirth: $dateBirth, localBirth: $localBirth, timeBirth: $timeBirth)';
}
