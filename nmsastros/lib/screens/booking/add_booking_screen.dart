import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nmsastros/models/booking/booking.dart';
import 'package:nmsastros/models/booking/booking_services.dart';
import 'package:nmsastros/models/chart/chart_services.dart';
import 'package:nmsastros/models/user/user_local.dart';
import 'package:nmsastros/screens/booking/select_profile_list_screen.dart';

class AddBookingScreen extends StatefulWidget {
  final UserLocal _userLocal;
  const AddBookingScreen(this._userLocal, {Key? key}) : super(key: key);

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final ChartServices _chartServices = ChartServices();
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var _selectedItemChart;

  String chartId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Solicitar leitura de Mapa",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _chartServices.getChart(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<DropdownMenuItem<String>> areaItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snapDoc = snapshot.data!.docs[i];
                        areaItems.add(
                          DropdownMenuItem<String>(
                            child: Column(children: [
                              Text(snapDoc.get('name'),
                                  style: const TextStyle(
                                      color: Color(0xFFEFF7F6))),
                              Text(snapDoc.get('preco'),
                                  style: const TextStyle(
                                      color: Color(0xFFEFF7F6))),
                            ]),
                            value: snapDoc.id,
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Solicitar mapa: "),
                          DropdownButton(
                              value: _selectedItemChart,
                              items: areaItems,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItemChart = value;
                                });
                                ScaffoldMessenger(
                                  child: SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text("Mapa atual é $value")),
                                );
                              },
                              hint: const Text("Escolha o tipo de mapa",
                                  style: TextStyle(
                                    color: Color(
                                      0xFFEFF7F6,
                                    ),
                                  ))),
                        ],
                      );
                    }
                  }),
              Center(
                child: SizedBox(
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final booking = Booking(
                                chartId: _selectedItemChart,
                                userId: widget._userLocal.id!);
                            BookingServices _bookingServices =
                                BookingServices();
                            _bookingServices.addBooking(booking);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SelectProfileListScreen(),
                              ),
                            );
                          }
                        },
                        child: const Text("Enviar"),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _userLocal {}
