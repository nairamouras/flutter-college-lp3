import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/nmastros_service.dart';

//objeto para apresentação dos dados existentes
class NmsastrosListSrceen extends StatelessWidget {
  const NmsastrosListSrceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NmsastrosService nmsastrosService = NmsastrosService();
    return StreamBuilder<QuerySnapshot>(
        //o stream é a propriedade que vai receber o fluxo de dados vindo do Firebase
        stream: nmsastrosService.getNmsastrosList(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            final List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ), //o separador, mostra uma separação na listagem
                itemCount: docSnap.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      docSnap[index].get('name'),
                    ),
                  );
                });
          }
        });
  }
}
