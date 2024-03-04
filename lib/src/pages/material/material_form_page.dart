import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class MaterialFormPage extends StatefulWidget {
  const MaterialFormPage({super.key});

  @override
  State<MaterialFormPage> createState() => _MaterialFormPageState();
}

class _MaterialFormPageState extends State<MaterialFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo material'),
        actions: [
          IconButton(
              onPressed: () {}, tooltip: 'Salvar', icon: const Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome do Material',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tipo de Material',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantidade em Estoque',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Unidade de Medida',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preço por Unidade',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Fornecedor',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Data da Última Compra',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Observações',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
