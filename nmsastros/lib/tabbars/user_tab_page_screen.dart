import 'package:flutter/material.dart';
import 'package:nmsastros/models/user/user_services.dart';
import 'package:nmsastros/screens/user/user_home_screen.dart';
import 'package:provider/provider.dart';

class UserTabPageScreen extends StatefulWidget {
  const UserTabPageScreen({Key? key}) : super(key: key);

  @override
  State<UserTabPageScreen> createState() => _UserTabPageScreenState();
}

class _UserTabPageScreenState extends State<UserTabPageScreen> {
  final List<String> _myList = ['Serviços', 'Publicações'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _myList.length,
      child: Consumer<UserServices>(builder: (_, userServices, __) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // ignore: prefer_const_constructors
            title: Center(
                child: Text(
              'Olá, ${userServices.userLocal?.name}',
              style: const TextStyle(),
            )),
            bottom: TabBar(
              tabs: _myList.map(
                (e) {
                  return Tab(
                    text: e.toString(),
                  );
                },
              ).toList(),
            ),
          ),
          // ignore: prefer_const_constructors
          body: TabBarView(
            children: [
              UserHomeScreen(userServices.userLocal!),
              const Center(child: Text('Publicações no instagram: @nmsastros')),
            ],
          ),
        );
      }),
    );
  }
}
