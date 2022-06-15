import 'package:flutter/material.dart';
import 'package:nmsastros/models/user/user_local.dart';
import 'package:nmsastros/screens/home/main_home_screen.dart';
import 'package:nmsastros/screens/login/signup_screen.dart';
import 'package:nmsastros/models/user/user_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserLocal userLocal = UserLocal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      'https://cdn.discordapp.com/attachments/749787358936825909/983502391980752988/logo.png',
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("App Astrologia Interpessoal",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 40),
                  Card(
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) => userLocal.email = value,
                                  initialValue: userLocal.email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: 'E-mail...',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top: 0), // add padding to adjust icon
                                      child: Icon(Icons.email),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Por Favor,  insira o email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  textInputAction: TextInputAction.done,
                                  onSaved: (value) =>
                                      userLocal.password = value,
                                  initialValue: userLocal.password,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Senha...',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top: 0), // add padding to adjust icon
                                      child: Icon(Icons.lock),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Por Favor,  insira a senha';
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    UserServices _userServices = UserServices();
                                    _userServices.signIn(
                                      userLocal,
                                      onSucess: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainHomeScreen()));
                                      },
                                      onFail: (e) {
                                        Text('$e');
                                      },
                                    );
                                  }
                                },
                                child: const Text('Entrar'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ));
                                },
                                child: const Text('Registrar-se'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
