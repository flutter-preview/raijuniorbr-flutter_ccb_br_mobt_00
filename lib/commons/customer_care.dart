import 'package:flutter/material.dart';

class CustomerCare extends StatelessWidget {
  const CustomerCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canais de Atendimento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.contact_emergency,
              //color: Colors.red,
              size: 24.0,
              //semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(
              'De seg. a sex., das 9h às 18h.\n',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const CustomerCareCard(
                title: 'SAC',
                line1: '0800 701 0224',
                line2: 'Reclamações, Cancelamentos e Inf. Gerais'),
            const CustomerCareCard(
                title: 'SAC Crédito Consignado',
                line1: '0800 725 0048',
                line2: 'Reclamações, Cancelamentos e Inf. Gerais'),
            const CustomerCareCard(
                title: 'SAC Cartão de Crédito',
                line1: '0800 775 7001',
                line2: 'Reclamações, Cancelamentos e Inf. Gerais'),
            const CustomerCareCard(
                title: 'Deficiente Auditivo ou de Fala',
                line1: '0800 940 0649',
                line2: 'Reclamações, Cancelamentos e Inf. Gerais'),
            const CustomerCareCard(
                title: 'Ouvidoria',
                line1: '0800 725 2242',
                line2: 'Se não ficar satisfeito com a solução'),
            const CustomerCareCard(
                title: 'Agências CCb Brasil',
                line1: 'Conheça nossa Rede de Agências',
                line2: 'x'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class CustomerCareCard extends StatelessWidget {
  const CustomerCareCard({
    super.key,
    required this.title,
    required this.line1,
    required this.line2,
  });

  final String title;
  final String line1;
  final String line2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      //color: theme.colorScheme.primary,
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(line1, style: theme.textTheme.titleMedium),
          ),
          if (line2 != 'x')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(line2, style: theme.textTheme.titleMedium),
            ),
        ],
      ),
    );
  }
}
