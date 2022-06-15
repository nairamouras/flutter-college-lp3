import 'package:flutter/material.dart';
import 'package:nmsastros/helpers/validators.dart';
import 'package:nmsastros/models/user/user_local.dart';
import 'package:nmsastros/models/user/user_services.dart';

class SignUpScreen extends StatelessWidget {
  //Utilizado para que possamos acessar o formulário nesta tela
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UserLocal userLocal = UserLocal();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Criar Conta de Usuário'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formkey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    textInputAction: TextInputAction.next,

                    decoration:
                        const InputDecoration(hintText: 'Nome completo'),
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Campo obrigatório!!!';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Preencha seu nome completo';
                      }
                      return null;
                    },
                    //evita o uso de controladores
                    onSaved: (name) => userLocal.name = name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Campo obrigatório!!!';
                      } else if (!emailValidator(email)) {
                        return 'E-mail inválido!!!';
                      }
                      return null;
                    },
                    onSaved: (email) =>
                        userLocal.email = email, //salva no email diretamennte
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (password) {
                      if (password!.isEmpty) {
                        return 'Campo obrigatório!!!';
                      } else if (password.length < 6) {
                        return 'Senha deve ter ao menos 6 caracteres!!!';
                      }
                      return null;
                    },
                    onSaved: (password) => userLocal.password = password,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration:
                        const InputDecoration(hintText: 'Repita a senha'),
                    // enabled: !userManager.loading,
                    obscureText: true,
                    validator: (passwordConfirm) {
                      if (passwordConfirm!.isEmpty) {
                        return 'Campo obrigatório!!!';
                      } else if (passwordConfirm.length < 6) {
                        return 'Senha deve ter ao menos 6 caracteres!!!';
                      }
                      return null;
                    },
                    onSaved: (password) => userLocal.confirmPassword = password,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: false
                        ? null
                        : () {
                            if (formkey.currentState!.validate()) {
                              //chama o método onSave de cada um dos formsfield
                              //os campos deveram ter onsaved habilitado00
                              formkey.currentState!.save();
                              if (userLocal.password !=
                                  userLocal.confirmPassword) {
                                const ScaffoldMessenger(
                                  child: SnackBar(
                                    content: Text(
                                      'Senhas não coincidem!!!',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              UserServices userServices = UserServices();
                              userServices.signUp(
                                userLocal,
                                onSucess: () {
                                  Navigator.of(context).pop();
                                },
                                onFail: (e) {
                                  ScaffoldMessenger(
                                    child: SnackBar(
                                      content: Text(
                                        'Falha ao registrar usuário: $e',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                    child: const Text(
                      'Criar conta',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
