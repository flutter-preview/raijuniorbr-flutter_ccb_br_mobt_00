/*
HomeCCB
-------

This is the main MENU of the app´s options

Jun/2023
Author: Rai Junior
*/

import 'dart:developer';
//import 'dart:html';
import 'package:flutter_ccb_br_mobt_00/commons/list_tokens.dart';

import '../commons/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Based on MATERIAL
import 'package:flutter/material.dart';

// >  Import the businesses modules
import '../commons/customer_care.dart';
// >> Project´s global vars
import '../commons/globalvars.dart' as globals;

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
      body: customContainer(
        context,
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Text('Prefs: ${snapshot.data!.getStringList('items')}'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.0)),
                                onPressed: () {
                                  if (snapshot.data!.getStringList('items') ==
                                          null ||
                                      snapshot.data!
                                          .getStringList('items')!
                                          .isEmpty) {
                                    Navigator.pushNamed(
                                        context, globals.routeTokenActivate);
                                  } else {
                                    log('globals.tokens = ${snapshot.data!.getStringList('items')}');
                                    Navigator.pushNamed(
                                        context, globals.routeTokenGenerator);
                                  }
                                },
                                child: const Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.token,
                                      size: 36,
                                    ),
                                    Text('Token',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              // About
                              ElevatedButton(
                                //style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.0)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomerCare()),
                                  );
                                },
                                child: const Column(children: <Widget>[
                                  Icon(
                                    Icons.help,
                                    size: 36,
                                  ),
                                  Text('Ajuda',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white)),
                                ]),
                              ),
                              // Tokens List
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.0)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ListTokens()),
                                  );
                                },
                                child: const Column(children: <Widget>[
                                  Icon(
                                    Icons.edit,
                                    size: 36,
                                  ),
                                  Text('Lista Tokens',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white)),
                                ]),
                              ),
                            ],
                          ),
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
