import 'package:flutter/material.dart';
import 'package:nmsastros/models/nmsastros.dart';

import '../models/nmastros_service.dart';

class NmsastrosAddScreen extends StatefulWidget {
  const NmsastrosAddScreen({Key? key}) : super(key: key);

  @override
  State<NmsastrosAddScreen> createState() => _NmsastrosAddScreenState();
}

class _NmsastrosAddScreenState extends State<NmsastrosAddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController localController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Cadastrar dados de nascimento")),
        body: SingleChildScrollView(
            child: Form(
          key:
              _formKey, //chave utilizada para permitir a intervenção de eventos no formulário
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Nome",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  //O controller permite que possamos interagir com o conteúdo do campo texto
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, entre com o nome';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Data',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: dateController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 2),
                    ),
                  ),
                ),
                const Text(
                  'Horário',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: timeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 2),
                    ),
                  ),
                ),
                const Text(
                  'Local',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: localController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //Acessar serviços de persistências, regras de negócios e outros
                        NmsastrosService service = NmsastrosService();
                        Nmsastros nmsastros = Nmsastros(
                            dateController.text,
                            nameController.text,
                            timeController.text,
                            localController.text);
                        service.add(nmsastros);
                      }
                    }, //incluir regras para tratamento das informações e persistência
                    child: const Text("Salvar dados"),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
