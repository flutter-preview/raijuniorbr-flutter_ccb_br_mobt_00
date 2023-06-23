// Based on MATERIAL package
import 'package:flutter/material.dart';

class TokenGenerator extends StatelessWidget {
  const TokenGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Token'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'TOKEN.\n',
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
