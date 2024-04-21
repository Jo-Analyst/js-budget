import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/material/material_controller.dart';
import 'package:js_budget/src/modules/material/material_form/material_form_controller.dart';

import 'package:js_budget/src/modules/widget/custom_show_dialog.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class MaterialFormPage extends StatefulWidget {
  const MaterialFormPage({
    super.key,
  });

  @override
  State<MaterialFormPage> createState() => _MaterialFormPageState();
}

class _MaterialFormPageState extends State<MaterialFormPage>
    with MaterialFormController {
  final controller = Injector.get<MaterialController>();
  final _formKey = GlobalKey<FormState>();
  int quantityInStock = 0;
  bool isCkecked = true;
  DateTime dateOfPurchase = DateTime.now();
  MaterialModel? material;
  String unit = 'Unidade';

  @override
  void initState() {
    super.initState();
    dateOfLastPurchaseEC.text = UtilsService.dateFormat(dateOfPurchase);
    material = controller.model();

    if (material != null) {
      initilizeForm(
        material!,
      );
      quantityInStock = material!.quantity;
      unit = material!.unit;
    }
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
        title: Text(material != null ? 'Editar material' : 'Novo material'),
        actions: [
          IconButton(
            onPressed: () async {
              var nav = Navigator.of(context);
              if (_formKey.currentState!.validate()) {
                await controller.save(
                  saveMaterial(material?.id ?? 0, unit),
                );

                nav.pop();
                if (material != null) {
                  nav.pop();
                }
              }
            },
            tooltip: 'Salvar',
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Visibility(
                visible: material != null,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Adicionar as alterações no mês atual',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  leading: Switch(
                    value: isCkecked,
                    onChanged: (value) {
                      setState(() {
                        isCkecked = value;
                      });
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameEC,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          labelText: 'Nome do Material*',
                          labelStyle: const TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Image.asset(
                            'assets/images/materia-prima-28px.png',
                            width: 25,
                          ),
                        ),
                        style: textStyleSmallDefault,
                        validator: Validatorless.required(
                            'Nome do material obrigatório.'),
                      ),
                      TextFormField(
                        controller: typeMaterialEC,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          labelText: 'Tipo de Material',
                          labelStyle: const TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Image.asset(
                            'assets/images/materia-prima-28px.png',
                            width: 25,
                          ),
                        ),
                        style: textStyleSmallDefault,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: quantityInStockEC,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              readOnly: material != null,
                              decoration: const InputDecoration(
                                labelText: 'Quantidade em Estoque*',
                                labelStyle: TextStyle(fontFamily: 'Poppins'),
                                suffixIcon: Icon(Icons.format_list_numbered),
                              ),
                              style: textStyleSmallDefault,
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return 'Quantidade em estoque obrigatório';
                                  }

                                  if (int.parse(value) == 0) {
                                    return 'Quantidade em estoque deve ser maior que zero';
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Visibility(
                                visible: material != null,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    final quantity = await showAlertDialog(
                                      context,
                                      'Adicione mais quantidade ao estoque',
                                      buttonTitle: 'Concluir',
                                    );

                                    if (quantity != null) {
                                      final sum =
                                          int.parse(quantityInStockEC.text) +
                                              quantity;
                                      quantityInStockEC.text = sum.toString();
                                    }
                                  },
                                  tooltip: 'Adicionar Quantidade',
                                  icon: const Icon(
                                    Icons.add_circle_outline_outlined,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: material != null,
                                child: IconButton(
                                  onPressed: () async {
                                    final quantity = await showAlertDialog(
                                      context,
                                      'Diminua quantidade do estoque',
                                      buttonTitle: 'Concluir',
                                    );

                                    if (quantity != null) {
                                      final sum =
                                          int.parse(quantityInStockEC.text) -
                                              quantity;
                                      quantityInStockEC.text = sum.toString();
                                    }
                                  },
                                  tooltip: 'Diminuir quantidade',
                                  icon: const Icon(
                                    Icons.remove_circle_outline_outlined,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      DropdownButtonFormField<String>(
                        value: unit,
                        decoration: const InputDecoration(
                          labelText: 'Unidade de medida',
                          suffixIcon: Icon(Icons.square_foot_sharp),
                        ),
                        items: <String>[
                          'Caixa',
                          'Centímetro (cm)',
                          'Centímetro quadrado (cm²)',
                          'Centímetro cúbico (cm³)',
                          'Grama (g)',
                          'Metro (m)',
                          'Metro quadrado (m²)',
                          'Metro cúbico (m³)',
                          'Milímetro (mm)',
                          'Milímetro quadrado (mm²)',
                          'Milímetro cúbico (mm³)',
                          'Pacote',
                          'Quilograma (kg)',
                          'Unidade',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          unit = value!;
                        },
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
                          suffixIcon: Icon(Icons.price_change),
                        ),
                        style: textStyleSmallDefault,
                      ),
                      FieldDatePicker(
                        controller: dateOfLastPurchaseEC,
                        initialDate: dateOfPurchase,
                        labelText: material != null
                            ? 'Última data da compra'
                            : 'Data da compra',
                        onSelected: (date) {
                          setState(() {
                            dateOfPurchase = date;
                          });
                          dateOfLastPurchaseEC.text =
                              UtilsService.dateFormat(date);
                        },
                      ),
                      TextFormField(
                        controller: supplierEC,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: const InputDecoration(
                          labelText: 'Fornecedor',
                          labelStyle: TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Icon(Icons.local_shipping_outlined),
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
                          suffixIcon: Icon(Icons.note_alt_outlined),
                        ),
                        style: textStyleSmallDefault,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
