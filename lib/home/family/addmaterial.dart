import 'package:flutter/material.dart';
import 'package:bouda/models/famille.dart';
import 'package:bouda/models/materiel.dart';
import 'package:bouda/services/family/familyservice.dart';
import 'package:bouda/services/materiell/materilservice.dart';
import 'package:bouda/services/utility/dialog.dart';

class AddMaterial extends StatefulWidget {
  final String? famille;
  const AddMaterial({Key? key,required this.famille}) : super(key: key);
  @override
  State<AddMaterial> createState() => _MymatState();
}

class _MymatState extends State<AddMaterial> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nomMateriel;
  int? qnt;
  DateTime? dateA;
  String? nomF;
  List<Famille>? allFamily;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext mycontext) {
    return Form(
        key: _formKey,
        child: FutureBuilder<List<Famille>>(
          future: Familyservice.getAllFamily(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Famille>> snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    setState(() {
                      nomMateriel = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter quantite',
                  ),
                  validator: (String? value) {
                    if (value == null) {
                      return 'Please enter some text';
                    }
                    setState(() {
                      qnt = int.parse(value);
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      DateTime? date = await MyDialog.dateDialog(context);
                      setState(() {
                        dateA = date;
                      });
                    },
                    child: const Text("Date d'acquition")),
                
                ElevatedButton(
                  child: const Text('add'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool state = await Materielservice.add(
                          Materiel.create(nomMateriel, qnt, dateA, nomF= widget.famille));
                      state
                          ? MyDialog.fullDialog(context, "MATERIAL ADDED")
                          : MyDialog.fullDialog(context, "ERROR");
                    }
                  },
                ),
              ],
            );
          },
        ));
  }
}
