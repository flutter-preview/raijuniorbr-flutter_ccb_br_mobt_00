//--------------------------------------------
// _loadItens
//
// Load data recorded in the device
//--------------------------------------------
import 'package:shared_preferences/shared_preferences.dart';

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
