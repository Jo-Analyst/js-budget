import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/pages/material/material_form_controller.dart';
import 'package:js_budget/src/pages/material/widget/custom_show_dialog.dart';
import 'package:js_budget/src/pages/widgets/field_date_picker.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:validatorless/validatorless.dart';

class MaterialFormPage extends StatefulWidget {
  final MaterialModel? material;
  final bool isEdition;
  const MaterialFormPage({
    super.key,
    this.material,
    this.isEdition = false,
  });

  @override
  State<MaterialFormPage> createState() => _MaterialFormPageState();
}

class _MaterialFormPageState extends State<MaterialFormPage>
    with MaterialFormController {
  final _formKey = GlobalKey<FormState>();
  int quantityInStock = 0;
  bool isCkecked = true;
  DateTime dateOfPurchase = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateOfLastPurchaseEC.text = UtilsService.dateFormat(dateOfPurchase);
    if (widget.material != null) {
      initilizeForm(widget.material!);
      quantityInStock = widget.material!.quantity;
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
        title: Text(widget.isEdition ? 'Editar material' : 'Novo material'),
        actions: [
          IconButton(
            onPressed: () {
              _formKey.currentState!.validate();
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
                visible: widget.isEdition,
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
                              readOnly: widget.isEdition,
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
                                visible: widget.isEdition,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    final quantity = await showAlertDialog(
                                      context,
                                      'Adicione mais quantidade ao estoque',
                                      buttonTitle: 'Concluir',
                                    );

                                    if (quantity != null) {
                                      quantityInStockEC.text =
                                          (int.parse(quantityInStockEC.text) +
                                                  quantity)
                                              .toString();
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
                                visible: widget.isEdition,
                                child: IconButton(
                                  onPressed: () async {
                                    final quantity = await showAlertDialog(
                                      context,
                                      'Diminua quantidade do estoque',
                                      buttonTitle: 'Concluir',
                                    );

                                    if (quantity != null) {
                                      quantityInStockEC.text =
                                          (int.parse(quantityInStockEC.text) -
                                                  quantity)
                                              .toString();
                                      setState(() {});
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
                      TextFormField(
                        controller: unitMaterialEC,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        decoration: const InputDecoration(
                          labelText: 'Unidade de Medida*',
                          labelStyle: TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Icon(Icons.square_foot_sharp),
                        ),
                        style: textStyleSmallDefault,
                        validator: Validatorless.required(
                            'Unidade de medida obrigatório.'),
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
                        labelText: widget.isEdition
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
