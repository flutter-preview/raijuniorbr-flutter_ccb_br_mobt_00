//--------------------------------------------
// _loadItens
//
// Load data recorded in the device
//--------------------------------------------

// URL Launcher
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*------------------------------------------------------------
_launchURLApp executa a URL que virá na leitura do QRCode
_launchURLApp execute URL received from QRCode

Sample from QRCode:
------------------
{
"code":"PEhedStqb6X1xBM3VfM2iXs99Vdk3G",
"options":"ignoreSslCerts=true",
"details_url":"https:\/\/www2.des.br.ccb.com:8443\/mga\/sps\/mmfa\/user\/mgmt\/details",
"version":1,
"client_id":"AuthenticatorClient"
}
------------------------------------------

Future<dynamic> _launchURLApp(String? code) async {
  var uri = 'https:\/\/www2.des.br.ccb.com:8443\/mga\/sps\/mmfa\/user\/mgmt\/details'
      '/cadastrar'; //code.details_url!;
  var url = Uri.parse(uri);

  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Não pode executar $url';
  }

  return true;
}
*/

Future<SharedPreferences> loadItems() async {
  final prefs = await SharedPreferences.getInstance();

  // Para debugar... descomente essa linha
  // Irá resetar o token:
  List<String>? tokens = prefs.getStringList('items');
  tokens = [];
  prefs.setStringList('items', tokens);

  if (tokens.isEmpty) {
    tokens = <String>[];
    tokens.add('teste1');
    tokens.add('teste2');
    prefs.setStringList('items', tokens);
  }

  return prefs;
}

Container customContainer(context, child) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
        // image: DecorationImage(
        //     image: AssetImage('assets/img/backgroundCCB.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //       Colors.grey,
        //       BlendMode.saturation,
        //     )),
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blueAccent, Colors.white, Colors.black],
      stops: [0.1, 0.5, 0.9],
    )),
    child: child,
  );
}
