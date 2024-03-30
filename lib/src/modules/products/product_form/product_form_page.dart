import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/modules/products/product_controller.dart';
import 'package:js_budget/src/modules/products/product_form/product_form_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:validatorless/validatorless.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage>
    with ProductFormController {
  final controller = Injector.get<ProductController>();
  final _formKey = GlobalKey<FormState>();
  String unit = 'Unidade Padrão';

  ProductModel? product;

  @override
  void initState() {
    super.initState();
    product = controller.model();

    if (product != null) {
      initializeForm(product!);
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
        title: Text(product != null ? 'Editar produto' : 'Novo produto'),
        actions: [
          IconButton(
            onPressed: () async {
              var nav = Navigator.of(context);
              if (_formKey.currentState!.validate()) {
                await controller.save(
                  save(product?.id ?? 0, unit),
                );

                nav.pop();
                if (product != null) {
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
                          labelText: 'Nome do Produto*',
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
                              maxLines: 5,
                              controller: descriptionEC,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              keyboardType: TextInputType.text,
                              readOnly: product != null,
                              decoration: const InputDecoration(
                                labelText: 'Descrição detalhada do produto',
                                labelStyle: TextStyle(fontFamily: 'Poppins'),
                                suffixIcon: Icon(Icons.description),
                              ),
                              style: textStyleSmallDefault,
                            ),
                          ),
                        ],
                      ),
                      DropdownButtonFormField<String>(
                        value: unit,
                        decoration: const InputDecoration(
                          labelText: 'Unidade',
                          suffixIcon: Icon(Icons.square_foot_sharp),
                        ),
                        items: <String>[
                          'Unidade Padrão',
                          'Pacote',
                          'Caixa',
                          'Milímetro (mm)',
                          'Milímetro quadrado (mm²)',
                          'Milímetro cúbico (mm³)',
                          'Centímetro (cm)',
                          'Centímetro quadrado (cm²)',
                          'Centímetro cúbico (cm³)',
                          'Metro (m)',
                          'Metro quadrado (m²)',
                          'Metro cúbico (m³)',
                          'Grama (g)',
                          'Quilograma (kg)',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          unit = value!;
                        },
                      )
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
