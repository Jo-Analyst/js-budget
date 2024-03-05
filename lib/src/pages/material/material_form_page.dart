import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/pages/material/material_form_controller.dart';
import 'package:js_budget/src/pages/widgets/custom_show_dialog.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class MaterialFormPage extends StatefulWidget {
  const MaterialFormPage({
    super.key,
  });

  @override
  State<MaterialFormPage> createState() => _MaterialFormPageState();
}

class _MaterialFormPageState extends State<MaterialFormPage>
    with MaterialFormController {
  final _formKey = GlobalKey<FormState>();
  bool isEdition = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null) return;

    final material = arguments as Map<String, dynamic>;

    initilizeForm(material['data']);
    isEdition = material['isEdition'];
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
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      readOnly: isEdition,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade em Estoque',
                        labelStyle: TextStyle(fontFamily: 'Poppins'),
                      ),
                      style: textStyleSmallDefault,
                    ),
                  ),
                  Visibility(
                    visible: isEdition,
                    child: IconButton(
                      onPressed: () async {
                        final result = await showAlertDialog(
                            context, 'Adicione mais quantidade ao estoque',
                            buttonTitle: 'Concluir');

                        print(result);
                      },
                      tooltip: 'Adicionar Quantidade',
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
