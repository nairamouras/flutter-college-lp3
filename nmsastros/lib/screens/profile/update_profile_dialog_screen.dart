import 'package:flutter/material.dart';
import 'package:nmsastros/models/profile/profile.dart';
import 'package:nmsastros/models/profile/profile_services.dart';

class UpdateProfileDialogScreen extends StatefulWidget {
  const UpdateProfileDialogScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileDialogScreen> createState() =>
      _UpdateProfileDialogScreenState();
}

class _UpdateProfileDialogScreenState extends State<UpdateProfileDialogScreen> {
  String? newProfileName;
  String? newProfileDataBirth;
  String? newProfileLocalBirth;
  String? newProfileTimeBirth;

  ProfileServices _profileServices = ProfileServices();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar informações"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Novo nome"),
              autofocus: true,
              onChanged: (text) => newProfileName = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nova data de nascimento"),
              autofocus: true,
              onChanged: (text) => newProfileDataBirth = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Novo local de nascimento"),
              autofocus: true,
              onChanged: (text) => newProfileLocalBirth = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Novo horário de nascimento"),
              autofocus: true,
              onChanged: (text) => newProfileTimeBirth = text,
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
            if (newProfileName != null &&
                newProfileDataBirth != null &&
                newProfileLocalBirth != null &&
                newProfileTimeBirth != null) {
              _profileServices.addProfile(Profile(
                name: newProfileName!,
                dateBirth: newProfileDataBirth!,
                localBirth: newProfileLocalBirth!,
                timeBirth: newProfileTimeBirth!,
              ));
              Navigator.of(context).pop();
            }
          },
          child: const Text("Atualizar"),
        ),
      ],
    );
  }
}
