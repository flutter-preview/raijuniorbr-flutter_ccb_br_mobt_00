/*
HomeCCB
-------

This is the main MENU of the app´s options

Jun/2023
Author: Rai Junior
*/

import 'dart:developer';
//import 'dart:html';
import 'package:flutter_ccb_br_mobt_00/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Based on MATERIAL
import 'package:flutter/material.dart';

// >  Import the businesses modules
import 'customer_care.dart';
// >> Project´s global vars
import 'globalvars.dart' as globals;
import 'package:flutter_slidable/flutter_slidable.dart';

@immutable
class HomeCCB extends StatefulWidget {
  const HomeCCB({super.key});

  @override
  State<HomeCCB> createState() => _HomeCCBState();
}

class _HomeCCBState extends State<HomeCCB> {
  late Future<SharedPreferences> futurePrefs;
  List<String>? dataMap = ["id: 0, title: Zero", "rer"];

  void removeFromMap(id) {
    setState(() {
      dataMap!.removeAt(id);
    });
  }

  @override
  void initState() {
    super.initState();
    futurePrefs = loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('CCB Brasil - Tokens'),
      ),
      body: Container(
        // Wall paper
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/backgroundCCB.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                ))),
        // Basic options
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
/*             ListView(
              children: [
                for (var id = 0; id < dataMap!.length; id++) ...[
                  Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        removeFromMap(id);
                      }),
                      children: [
                        SlidableAction(
                          onPressed: (context) => removeFromMap(id),
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                        child: ListTile(
                      title: Text(
                        //'${dataMap[id]['title']} | realId=${dataMap[id]['id']} | listId=${id.toString()}',
                        '${dataMap![id]} | realId=${dataMap![id]} | listId=${id.toString()}',
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ),
                ],
              ],
            ),
 */
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 300),
              child: Image.asset(
                'assets/img/logoNovo.png',
                //                      opacity: const AlwaysStoppedAnimation(.5),
              ),
            ),
            FutureBuilder<SharedPreferences>(
              future: futurePrefs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    //Text('Prefs: ${snapshot.data!.getStringList('items')}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                            onPressed: () {
                              if (snapshot.data!.getStringList('items') == null ||
                                  snapshot.data!.getStringList('items')!.isEmpty) {
                                Navigator.pushNamed(context, globals.routeTokenActivate);
                              } else {
                                log('globals.tokens = ${snapshot.data!.getStringList('items')}');
                                Navigator.pushNamed(context, globals.routeTokenGenerator);
                              }
                            },
                            child: const Column(
                              children: <Widget>[
                                Icon(
                                  Icons.token,
                                  size: 42,
                                ),
                                Text('Token', style: TextStyle(fontSize: 24.0, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        // About
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CustomerCare()),
                            );
                          },
                          child: const Column(children: <Widget>[
                            Icon(
                              Icons.info,
                              size: 42,
                            ),
                            Text('Ajuda', style: TextStyle(fontSize: 24.0, color: Colors.white)),
                          ]),
                        ),
                      ],
                    ),
                  ]);
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
