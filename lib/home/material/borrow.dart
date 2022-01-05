import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:bouda/services/utility/router.dart';

class Borrow extends StatefulWidget {
  const Borrow({Key? key}) : super(key: key);
  @override
  State<Borrow> createState() => MyBorrowState();
}

class MyBorrowState extends State<Borrow> {
  final GlobalKey<NavigatorState> key = GlobalKey();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          body: Navigator(
              key: key,
              initialRoute: '/listBorrow',
              onGenerateRoute: borrowRoute),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            openCloseDial: isDialOpen,
            backgroundColor: Colors.blueAccent,
            overlayColor: Colors.grey,
            overlayOpacity: 0.4,
            spacing: 10,
            spaceBetweenChildren: 10,
            closeManually: true,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.list),
                  label: 'List borrow',
                  backgroundColor: Colors.blue[200],
                  foregroundColor: Colors.white,
                  onTap: () {
                    setState(() {
                      isDialOpen.value = false;
                    });
                    key.currentState!.pushNamed('/listBorrow');
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.archive_outlined),
                  label: 'History',
                  backgroundColor: Colors.blue[200],
                  foregroundColor: Colors.white,
                  onTap: () {
                    setState(() {
                      isDialOpen.value = false;
                    });
                    key.currentState!.pushNamed('/listHistory');
                  }),
            ],
          )),
    );
  }
}
