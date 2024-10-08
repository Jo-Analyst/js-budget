import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/models/product_model.dart';
import 'package:js_budget/src/modules/product/product_controller.dart';
import 'package:js_budget/src/modules/product/product_form/product_form_controller.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:js_budget/src/utils/flexible_text.dart';
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
  String unit = 'Unidade';

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
            icon: const Icon(
              Icons.save,
              size: 30,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Nome do produto
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
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Produto*',
                          labelStyle: TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Icon(Icons.local_offer),
                        ),
                        style: textStyleMediumDefault,
                        validator: Validatorless.required(
                            'Nome do produto obrigatório.'),
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
                      // Unidade
                      DropdownButtonFormField<String>(
                        value: unit,
                        decoration: const InputDecoration(
                          labelText: 'Unidade',
                        ),
                        items: <String>[
                          'Caixa',
                          'Centímetro(cm)',
                          'Centímetro quad.(cm²)',
                          'Centímetro cúbico(cm³)',
                          'Grama(g)',
                          'Metro(m)',
                          'Metro quadrado(m²)',
                          'Metro cúbico(m³)',
                          'Milímetro(mm)',
                          'Milímetro quad.(mm²)',
                          'Milímetro cúbico(mm³)',
                          'Pacote',
                          'Quilograma(kg)',
                          'Unidade',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: FlexibleText(
                              text: value,
                              maxFontSize: 15,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          unit = value!;
                        },
                      ),

                      // Descrição do produto
                      TextFormField(
                        maxLines: 5,
                        controller: descriptionEC,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Descrição detalhada do produto',
                          labelStyle: TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Icon(Icons.description),
                        ),
                        style: textStyleMediumDefault,
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
