import 'package:flutter/material.dart';
import 'package:nmsastros/models/chart/chart.dart';
import 'package:nmsastros/models/chart/chart_services.dart';

class AddChartDialogScreen extends StatefulWidget {
  const AddChartDialogScreen({Key? key}) : super(key: key);

  @override
  State<AddChartDialogScreen> createState() => _AddChartDialogScreenState();
}

class _AddChartDialogScreenState extends State<AddChartDialogScreen> {
  String? chartName;
  String? preco;
  ChartServices _chartServices = ChartServices();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Adicionar Mapa"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Nome do Mapa"),
              autofocus: true,
              onChanged: (text) => chartName = text,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Preço do Mapa"),
              autofocus: true,
              onChanged: (text) => preco = text,
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
            if (chartName != null && preco != null) {
              _chartServices.addChart(Chart(
                name: chartName!,
                preco: preco!,
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
