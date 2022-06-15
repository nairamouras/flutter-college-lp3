import 'package:flutter/material.dart';
import 'package:nmsastros/models/chart/chart.dart';
import 'package:nmsastros/models/chart/chart_services.dart';

class UpdateChartDialogScreen extends StatefulWidget {
  const UpdateChartDialogScreen({Key? key}) : super(key: key);

  @override
  State<UpdateChartDialogScreen> createState() =>
      _UpdateChartDialogScreenState();
}

class _UpdateChartDialogScreenState extends State<UpdateChartDialogScreen> {
  String? newChartName;
  String? newPreco;
  ChartServices _chartServices = ChartServices();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar Mapa"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Nono nome do Mapa"),
              autofocus: true,
              onChanged: (text) => newChartName = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Novo preço do Mapa"),
              autofocus: true,
              onChanged: (text) => newPreco = text,
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
            if (newChartName != null && newPreco != null) {
              _chartServices.updateChart(Chart(
                name: newChartName!,
                preco: newPreco!,
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
