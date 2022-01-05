import 'package:flutter/material.dart';
import 'package:bouda/home/family/addmaterial.dart';
import 'package:bouda/models/famille.dart';
import 'package:bouda/models/materiel.dart';
import 'package:bouda/services/materiell/materilservice.dart';
import 'package:bouda/services/utility/dialog.dart';

import 'listfamily.dart';

class MatFamily extends StatelessWidget{
  const MatFamily({Key? key, required this.famille}) : super(key: key);
  final Famille famille;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: <Widget>[

        TextButton(
          child: const Text('add material'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(8.0),
            textStyle: const TextStyle(fontSize: 20),
            primary: Colors.black,
            
            ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddMaterial(famille: famille.familyname.toString())),
            );
          },
        ),
              
        Expanded(  
          child: FutureBuilder(
              future: Materielservice.getMaterialByNomF(famille.familyname.toString()),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Materiel>> projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none ||
                    !projectSnap.hasData) {
                  return const Text("NO DATA");
                }
                return ListView.builder(
                    itemCount: projectSnap.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [

                          Card( 
                            elevation: 8,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.shop_two, size: 48),
                                  title: Text(
                                      projectSnap.data![index].nomMateriel!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(projectSnap.data![index].nomF!,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                          ),         
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Quantité : " +projectSnap.data![index].quantite.toString()
                                    ),
                                    Text(
                                      "date acquition : " +projectSnap.data![index].dateAcqui.toString()
                                    )
                                  ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text('Borrow'),
                                      onPressed: () async {
                                        MyDialog.borrowMaterialForm(
                                            context, projectSnap.data![index]);
                                      },
                                    ),
                                  ],
                                ),
                                
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              }),
        ),
        Align(
          alignment:const Alignment(-1.0,1.0),
          child: TextButton(
                child: const Icon(Icons.arrow_back, size: 48),   
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListFamily(),
                  ));
                },
              ),
        ),
            const SizedBox(width: 4),
      ],
    ));
  }
}
