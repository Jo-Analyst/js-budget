import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/pages/material/material_form_controller.dart';
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

class _MaterialFormPageState extends State<MaterialFormPage>
    with MaterialFormController {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final material =
        ModalRoute.of(context)!.settings.arguments as MaterialModel;
    initilizeForm(material);
  }

  @override
  void dispose() {
    super.dispose();
    disposeForm();
  }

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
                controller: nameEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Nome do Material',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                controller: typeMaterialEC,
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
                      controller: quantityInStockEC,
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
                controller: unitMaterialEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Unidade de Medida',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                controller: priceMaterialEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Preço por Unidade',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                controller: supplierEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Fornecedor',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
              ),
              TextFormField(
                controller: observationEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                maxLines: 5,
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
