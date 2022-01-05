import 'package:flutter/material.dart';
import 'package:bouda/models/materiel.dart';
import 'package:bouda/models/borrowed.dart';
import 'package:bouda/services/materiell/materilservice.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({Key? key}) : super(key: key);
  @override
  State<ListHistory> createState() => _ListHistory();
}

class _ListHistory extends State<ListHistory> {
  @override
  Widget build(BuildContext mycontext) {
    return FutureBuilder(
        future: Materielservice.getAllBorrowed(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Borrowed>> projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none ||
              !projectSnap.hasData) {
            return const Text("NO DATA");
          }

          return ListView.builder(
              itemCount: projectSnap.data!.length,
              itemBuilder: (context, index) {

                if (projectSnap.data![index].dateReturn != null &&
                    projectSnap.data![index].state != null) {
                return Column(
                  children: [
                    Card(
                      elevation: 8,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(
                              Icons.perm_identity_sharp,
                              size: 30,
                              color: Color.fromARGB(255, 3, 152, 252),
                            ),
                            title: Text(
                                projectSnap.data![index].firstName! +
                                    " " +
                                    projectSnap.data![index].lastName!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            subtitle: Text(projectSnap.data![index].phoneNumber
                                .toString()),
                          ),
                          FutureBuilder<Materiel>(
                            future: Materielservice.getMaterialById(
                                projectSnap.data![index].idMaterial!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.none ||
                                  !snapshot.hasData) {
                                return const Text("ERREUR DATA BASE");
                              }
                              return ListTile(
                                leading: const Icon(
                                  Icons.archive_sharp,
                                  size: 30,
                                  color: Color.fromARGB(255, 3, 152, 252),
                                ),
                                title: Text(snapshot.data!.nomMateriel!),
                                subtitle: Text("Quantity : " +
                                    projectSnap.data![index].quantite
                                        .toString()),
                              );
                            },
                          ),
                         Column(
                    children: <Widget>[
                      Chip(
                          label: Text("Date: "+
                              projectSnap.data![index].dateReturn.toString())),
                      Chip(

                          label: Text("state: "+projectSnap.data![index].state!)),
                    ],
                  )
                        ],
                      ),
                    ),
                  ],
                );}else{return const Text("");}
              });
        });
  }
}
