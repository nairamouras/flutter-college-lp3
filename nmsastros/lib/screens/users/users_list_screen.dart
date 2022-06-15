import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/user/user_services.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserServices _userServices = UserServices();
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de usuários cadastrados")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userServices.getUser(),
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
                              Text(docSnap[index].get('email')),
                            ],
                          ),
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
    );
  }
}
