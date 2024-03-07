import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/pages/material/material_form_controller.dart';
import 'package:js_budget/src/pages/material/widget/custom_show_dialog.dart';
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
    monthOfLastPurchaseEC.text = UtilsService.dateFormat(dateOfPurchase);
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
              TextFormField(
                controller: nameEC,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Nome do Material',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
                validator:
                    Validatorless.required('Nome do material obrigatório.'),
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
                      readOnly: widget.isEdition,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade em Estoque',
                        labelStyle: TextStyle(fontFamily: 'Poppins'),
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
                                context, 'Adicione mais quantidade ao estoque',
                                buttonTitle: 'Concluir');

                            if (quantity != null) {
                              quantityInStockEC.text =
                                  (int.parse(quantityInStockEC.text) + quantity)
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
                                context, 'Diminua quantidade do estoque',
                                buttonTitle: 'Concluir');

                            if (quantity != null) {
                              quantityInStockEC.text =
                                  (int.parse(quantityInStockEC.text) - quantity)
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
                  labelText: 'Unidade de Medida',
                  labelStyle: TextStyle(fontFamily: 'Poppins'),
                ),
                style: textStyleSmallDefault,
                validator:
                    Validatorless.required('Unidade de medida obrigatório.'),
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: monthOfLastPurchaseEC,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: widget.isEdition
                            ? 'Última data da compra'
                            : 'Data da compra',
                        labelStyle: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      style: textStyleSmallDefault,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDatePicker(
                        firstDate: DateTime(2020),
                        context: context,
                        lastDate: DateTime.now(),
                        initialDate: dateOfPurchase,
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            dateOfPurchase = date;
                            monthOfLastPurchaseEC.text =
                                UtilsService.dateFormat(date);
                          });
                        }
                      });
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      size: 35,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
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
