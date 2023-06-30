/*
Token_Activate
--------------

Activate the virtual token, reading from QRCode

Jun/2023
Author: Rai Junior
*/

// Based on MATERIAL
import 'package:flutter/material.dart';

// For QRCode
import 'package:qr_code_scanner/qr_code_scanner.dart';

// for Logs ...
import 'dart:developer';

// for IO operations
import 'dart:io';
import 'dart:async';
import 'dart:convert';

// URL Launcher
//import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Business module
// Project´s global vars
import 'globalvars.dart' as globals;

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

Future<bool> _saveItems(String json) async {
  List<String>? tokens;
  final prefs = await SharedPreferences.getInstance();
  try {
    tokens = [json];
    prefs.setStringList('items', tokens);
    return true;
  } on Exception catch (e) {
    log('Erro: ${e.toString()}');
    return false;
  }
}

Future<bool> fetchVirtualToken(QrCodeData? code) async {
  //var uri = 'https:\/\/www2.des.br.ccb.com:8443\/mga\/sps\/mmfa\/user\/mgmt\/details' '/cadastrar';
  var uri = code!.details_url;
  uri += '/cadastrar';

  var body = json.encode({
    "deviceName": "samsung",
    "deviceType": "SM-901E",
    "osVersion": "5.0.2",
    "applicationId": "br.com.ccb.mobile",
    "frontCameraSupport": "1",
    "fingerprintSupport": "0",
    "code": ""
  });

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  try {
    //final response = await http.get(Uri.parse(uri));
    final response = await http.post(Uri.parse(uri), body: body, headers: headers).timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      return true; // VirtualToken.fromJson(jsonDecode(response.body));
    } else {
      log('Erro no POST: ${response.statusCode}');
      // estou mockando
      return true;
      //return false;
    }
  } on TimeoutException {
    log('Erro timeout');
    return false;
  } on Exception catch (e) {
    log('Erro erro genérico: $e');
    return false;
  }
}

class VirtualToken {
  final String deviceName;
  final String deviceType;
  final String osVersion;
  final String applicationId;
  final String frontCameraSupport;
  final String fingerprintSupport;
  final String code;

  const VirtualToken({
    required this.deviceName,
    required this.deviceType,
    required this.osVersion,
    required this.applicationId,
    required this.frontCameraSupport,
    required this.fingerprintSupport,
    required this.code,
  });

  factory VirtualToken.fromJson(Map<String, dynamic> json) {
    return VirtualToken(
      deviceName: json['deviceName'],
      deviceType: json['deviceType'],
      osVersion: json['osVersion'],
      applicationId: json['applicationId'],
      frontCameraSupport: json['frontCameraSupport'],
      fingerprintSupport: json['fingerprintSupport'],
      code: json['code'],
    );
  }
}

/*
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
*/
class QrCodeData {
  final String code;
  final String options;
  final String details_url;
  final int version;
  final String client_id;

  const QrCodeData(
      {required this.code,
      required this.options,
      required this.details_url,
      required this.version,
      required this.client_id});

  factory QrCodeData.fromJson(Map<String, dynamic> json) {
    log('JSON = $json');
    return QrCodeData(
        code: json['code'],
        options: json['options'],
        details_url: json['details_url'],
        version: json['version'],
        client_id: json['client_id']);
  }
}

@immutable
class TokenActivate extends StatefulWidget {
  const TokenActivate({super.key});

  @override
  State<TokenActivate> createState() => _TokenActivateState();
}

class _TokenActivateState extends State<TokenActivate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.warning,
            color: Colors.red,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Text(
            'Você não possui Token ativo.\n',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Para ativar seu token virtual CCB Brasil\n'
              'entre no Internet Banking, menu\nOutros Serviços -> Ativar Token\n',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.pushNamed(context, globals.routeQRView);
/*               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QRViewCCB()),
              );
 */
            },
            label: Text('Ativar token virtual CCB Brasil', style: Theme.of(context).textTheme.titleLarge),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class ShowAlert extends StatefulWidget {
  const ShowAlert({super.key, required this.message, this.redAlert});

  final String message;
  final bool? redAlert;

  @override
  State<StatefulWidget> createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AlertDialog(
        backgroundColor: (widget.redAlert! ? Colors.red : Colors.green),
        title: Text('Alerta', style: Theme.of(context).textTheme.titleLarge),
        content: Text(widget.message, style: Theme.of(context).textTheme.titleMedium),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, globals.routeHome, (route) => false);
              },
              child: const Text('Fechar')),
        ],
      ),
    );
  }
}

class QRViewCCB extends StatefulWidget {
  const QRViewCCB({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewCCBState();
}

class _QRViewCCBState extends State<QRViewCCB> {
  late bool meuRetorno = false;
  Barcode? result;
  QrCodeData? qrCodeData;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _fetchData(BuildContext context, String? code) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    controller!.stopCamera();
    try {
      qrCodeData = QrCodeData.fromJson(jsonDecode(code!));
      // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
      meuRetorno = await fetchVirtualToken(qrCodeData);
      meuRetorno = await _saveItems(code);
    } on Exception catch (e) {
      log('Error: ${e.toString()}');
      meuRetorno = false;
    }
    //await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (mounted) {
      if (!meuRetorno) {
        //Navigator.pushReplacementNamed(context, globals.routeShowAlert);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  const ShowAlert(message: 'QRCode parece não ser compatível.\nTente novamente.', redAlert: true),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ShowAlert(
                message: 'QRCode ativado com sucesso!',
                redAlert: false,
              ),
            ));
      }
    }
    return;
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 2, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        icon: const Icon(Icons.app_registration),
                        onPressed: () => _fetchData(context, result?.code),
                        label: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                              //'Data: ${result!.code}\n'
                              'Leitura realizada.\nPressione para ativar.',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      ),
                    )
/*                     Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}\n'
                        //"${_launchURLApp(describeEnum(result!.format), result!.code)}")
                        "${_qrRead(describeEnum(result!.format), result!.code, context)}")
 */
                  else
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                          'Posicione seu celular na frente \n'
                          'da tela do seu computador para ler\n'
                          'a imagem QR Code gerada pelo \nInternet Banking.',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
/*                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
 */ /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),*/
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this CCB we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
