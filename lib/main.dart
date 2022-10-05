import 'package:flutter/material.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  void execTransfer(BuildContext context) {
    final int? numeroConta =
    int.tryParse(_controladorNumeroConta.text);
    final double? valor = double.tryParse(_controladorValor.text);
    if (numeroConta != null && valor != null) {
      final Transferencia transferencia = Transferencia(valor, numeroConta);
      debugPrint(transferencia.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(transferencia.toString()),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando Transferência'),
      ),
      body: Column(
        children: <Widget>[
          Editor(
            rotulo: 'Número da conta',
            dica: '0000',
            controlador: _controladorNumeroConta,
          ),
          Editor(
            rotulo: 'Valor',
            dica: '0.00',
            controlador: _controladorValor,
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed: () => execTransfer(context),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }
}

class Editor extends StatelessWidget {
  final String? rotulo;
  final String? dica;
  final TextEditingController? controlador;
  final IconData? icone;

  Editor({super.key, this.rotulo, this.dica, this.controlador, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
          icon: icone != null ? Icon(icone) : null,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTranferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(100, 1000)),
          ItemTransferencia(Transferencia(200, 2000)),
          ItemTransferencia(Transferencia(300, 3000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
    throw UnimplementedError();
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on_outlined),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
    throw UnimplementedError();
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
