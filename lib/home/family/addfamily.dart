import 'package:flutter/material.dart';
import 'package:bouda/services/utility/dialog.dart';
import 'package:bouda/models/famille.dart';
import 'package:bouda/services/family/familyservice.dart';

class AddFamily extends StatefulWidget {
  const AddFamily({Key? key}) : super(key: key);
  @override
  State<AddFamily> createState() => _MyFamilyState();
}

class _MyFamilyState extends State<AddFamily> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nomFamille;

  @override
  Widget build(BuildContext mycontext) {
    return Form(
      key: _formKey,
      child: Column(
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
                nomFamille = value;
              });
            },
          ),
          ElevatedButton(
            child: const Text('add'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool state =
                await Familyservice.add(Famille(familyname: nomFamille));
                await MyDialog.fullDialog(
                    context, state ? "INSERT SUCCESS" : "FAMILY EXISTS");
                Familyservice.getAllFamily();
                if (state) {
                  Navigator.pushNamed(context, '/listFamily');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
