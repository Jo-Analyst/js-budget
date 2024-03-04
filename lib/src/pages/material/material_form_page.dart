import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class MaterialFormPage extends StatefulWidget {
  final bool isEdition;
  const MaterialFormPage({
    this.isEdition = false,
    super.key,
  });

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
            onPressed: () {},
            tooltip: 'Salvar',
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              TextFormField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Nome do Material',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Tipo de Material',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      readOnly: widget.isEdition,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade em Estoque',
                        labelStyle: TextStyle(fontFamily: 'Poppins'),
                      ),
                      style: textStyleSmallDefault,
                    ),
                  ),
                  Visibility(
                    visible: widget.isEdition,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline_outlined),
                    ),
                  ),
                ],
              ),
              TextFormField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Unidade de Medida',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Preço por Unidade',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Fornecedor',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Data da Última Compra',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
