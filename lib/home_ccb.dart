/*
HomeCCB
-------

This is the main MENU of the app´s options

Jun/2023
Author: Rai Junior
*/

import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

// Based on MATERIAL
import 'package:flutter/material.dart';

// >  Import the businesses modules
import 'customer_care.dart';
// >> Project´s global vars
import 'globalvars.dart' as globals;

//--------------------------------------------
// _loadItens
//
// Load data recorded in the device
//--------------------------------------------
Future<SharedPreferences> _loadItems() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? tokens = prefs.getStringList('items');

  tokens = [];

  prefs.setStringList('items', tokens);

/*   if (tokens == null) {
    tokens = <String>[];
    tokens.add('teste1');
    tokens.add('teste2');
    prefs.setStringList('items', tokens);
  }
 */
  return prefs;
}

@immutable
class HomeCCB extends StatefulWidget {
  const HomeCCB({super.key});

  @override
  State<HomeCCB> createState() => _HomeCCBState();
}

class _HomeCCBState extends State<HomeCCB> {
  late Future<SharedPreferences> futurePrefs;

  @override
  void initState() {
    super.initState();
    futurePrefs = _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CCB Brasil - Tokens'),
      ),
      body: Container(
        // Wall paper
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/backgroundCCB.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.linearToSrgbGamma())),
        // Basic options
        child: FutureBuilder<SharedPreferences>(
          future: futurePrefs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                //Text('Prefs: ${snapshot.data!.getStringList('items')}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        label: Text('Token', style: Theme.of(context).textTheme.headlineSmall),
                        icon: const Icon(Icons.token),
                        onPressed: () {
                          if (snapshot.data!.getStringList('items') == null ||
                              snapshot.data!.getStringList('items')!.isEmpty) {
                            Navigator.pushNamed(context, globals.routeTokenActivate);
                          } else {
                            log('globals.tokens = ${snapshot.data!.getStringList('items')}');
                            Navigator.pushNamed(context, globals.routeTokenGenerator);
                          }
                        },
                      ),
                    ),
                    // About
                    ElevatedButton.icon(
                      label: Text('Sobre', style: Theme.of(context).textTheme.headlineSmall),
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CustomerCare()),
                        );
                      },
                    ),
                  ],
                ),
              ]);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
