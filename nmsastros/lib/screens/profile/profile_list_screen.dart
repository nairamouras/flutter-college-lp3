import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/profile/profile_services.dart';
import 'package:nmsastros/screens/profile/add_profile_dialog_screen.dart';
import 'package:nmsastros/screens/profile/update_profile_dialog_screen.dart';

class ProfileListScreen extends StatelessWidget {
  const ProfileListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileServices _profileServices = ProfileServices();
    return Scaffold(
        appBar: AppBar(title: const Text("Lista de pessoas adicionadas")),
        body: StreamBuilder<QuerySnapshot>(
          stream: _profileServices.getProfile(),
          builder: (BuildContext ctx, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<DocumentSnapshot> docSnap = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(docSnap[index].get('name')),
                                Text(docSnap[index].get('dateBirth')),
                                Text(docSnap[index].get('localBirth')),
                                Text(docSnap[index].get('timeBirth')),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  _updateProfile(context);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                )),
                            IconButton(
                                onPressed: () {
                                  _profileServices
                                      .deleteProfile(docSnap[index].id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      );
                    },
                    itemCount: docSnap.length,
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    }),
              );
            } else {
              return const Text("Dados disponíveis...");
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addProfile(context);
          },
          tooltip: 'Adicionar uma nova pessoa',
          child: const Icon(Icons.add),
        ));
  }

  void _addProfile(context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return const AddProfileDialogScreen();
      },
    );
  }

  void _updateProfile(context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return const UpdateProfileDialogScreen();
      },
    );
  }
}
