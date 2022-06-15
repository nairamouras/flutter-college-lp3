import 'package:flutter/material.dart';
import 'package:nmsastros/models/profile/profile.dart';
import 'package:nmsastros/models/profile/profile_services.dart';

class AddProfileDialogScreen extends StatefulWidget {
  const AddProfileDialogScreen({Key? key}) : super(key: key);

  @override
  State<AddProfileDialogScreen> createState() => _AddProfileDialogScreenState();
}

class _AddProfileDialogScreenState extends State<AddProfileDialogScreen> {
  String? profileName;
  String? profileDataBirth;
  String? profileLocalBirth;
  String? profileTimeBirth;

  ProfileServices _profileServices = ProfileServices();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Adicionar nova pessoa"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Nome completo"),
              autofocus: true,
              onChanged: (text) => profileName = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Data de nascimento"),
              autofocus: true,
              onChanged: (text) => profileDataBirth = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Local de nascimento"),
              autofocus: true,
              onChanged: (text) => profileLocalBirth = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Horário de nascimento"),
              autofocus: true,
              onChanged: (text) => profileTimeBirth = text,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            if (profileName != null &&
                profileDataBirth != null &&
                profileLocalBirth != null &&
                profileTimeBirth != null) {
              _profileServices.addProfile(Profile(
                name: profileName!,
                dateBirth: profileDataBirth!,
                localBirth: profileLocalBirth!,
                timeBirth: profileTimeBirth!,
              ));
              Navigator.of(context).pop();
            }
          },
          child: const Text("Adicionar"),
        ),
      ],
    );
  }
}
