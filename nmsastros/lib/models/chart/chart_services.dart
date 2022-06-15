import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nmsastros/models/chart/chart.dart';

class ChartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("chart");

  List<Chart> allChart = [];

  ChartServices() {
    _loadAllChart();
  }
  //método para adicionar/gravar dados no firebase
  Future<DocumentReference> addChart(Chart chart) {
    return _collectionReference.add(chart.toMap());
  }

//método utilizado para atualizar dados no firebase
  void updateChart(Chart chart) async {
    await _collectionReference.doc(chart.id).set(chart.toMap());
  }

//método utilizado para deletar dados no firebase
  void deleteChart(String id) async {
    await _collectionReference.doc(id).delete();
  }

  Stream<QuerySnapshot> getChart() {
    return _collectionReference.snapshots();
  }

  Future<void> _loadAllChart() async {
    _firestore.collection("chart").snapshots().listen((snap) {
      allChart = snap.docs.map((e) => Chart.fromDocument(e)).toList();
    });
  }
}
