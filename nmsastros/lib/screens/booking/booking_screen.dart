import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/booking/booking_services.dart';
import 'package:nmsastros/models/chart/chart_services.dart';
import 'package:nmsastros/models/user/user_local.dart';
import 'package:nmsastros/models/user/user_services.dart';
import 'package:nmsastros/screens/booking/add_booking_screen.dart';
import 'package:nmsastros/screens/chart/chart_user_list_screen.dart';

class BookingScreen extends StatefulWidget {
  final UserLocal _userLocal;
  const BookingScreen(this._userLocal, {Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  BookingServices _bookingServices = BookingServices();
  final ChartServices _chartServices = ChartServices();
  final UserServices _userServices = UserServices();
  String? chart;
  String? user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddBookingScreen(widget._userLocal),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                primary: Colors.black87,
                backgroundColor: const Color(0xFFEFF7F6),
              ),
              child: const Text("Solicitar confecção de Mapa"),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChartUserListScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                primary: Colors.black87,
                backgroundColor: const Color(0xFFEFF7F6),
              ),
              child: const Text("Meus Mapas"),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        const Text("Fila de espera dos Mapas solicitados"),
        Card(
            color: Colors.blueGrey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: StreamBuilder<QuerySnapshot>(
              stream: _bookingServices.getBookingList(),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<DocumentSnapshot> docSnap = snapshot.data!.docs;
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: const Text('Mapa'),
                              width: 130,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: const Text('Usuário'),
                              width: 130,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: docSnap.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                loadChart(docSnap[index].get('chartId'));
                                loadUser(docSnap[index].get('userId'));
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        chart!,
                                      ),
                                      Text(
                                        user!,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox(child: Text("Dados não disponíveis"));
                }
              },
            )),
      ],
    );
  }

  loadChart(String id) {
    for (int i = 0; i < _chartServices.allChart.length; i++) {
      if (_chartServices.allChart[i].id == id) {
        chart = _chartServices.allChart[i].name;
      }
    }
  }

  loadUser(String id) {
    for (int i = 0; i < _userServices.allUser.length; i++) {
      if (_userServices.allUser[i].id == id) {
        user = _userServices.allUser[i].name;
      }
    }
  }
}
