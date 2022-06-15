import 'package:flutter/material.dart';
import 'package:nmsastros/models/user/user_local.dart';
import 'package:nmsastros/screens/booking/booking_screen.dart';

class UserHomeScreen extends StatefulWidget {
  final UserLocal _userLocal;
  const UserHomeScreen(this._userLocal, {Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            BookingScreen(widget._userLocal),
          ],
        ),
      ),
    );
  }
}
