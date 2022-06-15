import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/chart/chart_services.dart';
import 'package:nmsastros/screens/chart/add_chart_dialog_screen.dart';
import 'package:nmsastros/screens/chart/update_chart_dialog_screen.dart';

class ChartListScreen extends StatelessWidget {
  const ChartListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChartServices _chartServices = ChartServices();
    return Scaffold(
        appBar: AppBar(title: const Text("Lista de Mapas disponíveis")),
        body: StreamBuilder<QuerySnapshot>(
          stream: _chartServices.getChart(),
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
                                Text(docSnap[index].get('preco')),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  _updateChart(context);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                )),
                            IconButton(
                                onPressed: () {
                                  _chartServices.deleteChart(docSnap[index].id);
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
            _addChart(context);
          },
          tooltip: 'Adicionar Mapa',
          child: const Icon(Icons.add),
        ));
  }

  void _addChart(context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return const AddChartDialogScreen();
      },
    );
  }

  void _updateChart(context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return const UpdateChartDialogScreen();
      },
    );
  }
}
