import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nmsastros/models/booking/booking.dart';

class BookingServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //método para persistir (gravar) dados no firebase
  addBooking(Booking booking) {
    _firestore.collection('booking').add(booking.toMap());
  }

  //obtém lista de todos os dados no firebase
  Stream<QuerySnapshot> getBookingList() {
    CollectionReference bookingRef = _firestore.collection('booking');
    return bookingRef.snapshots();
  }

  Future getBookingById(String id) async {
    var collection = _firestore.collection('booking');
    var docSnapshot = await collection.doc(id).get();
    Map<String, dynamic>? data = docSnapshot.data();
    return Future.value(data!['chart']);
  }
}
