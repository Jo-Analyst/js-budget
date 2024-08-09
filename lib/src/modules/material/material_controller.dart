import 'package:flutter_getit/flutter_getit.dart';
import 'package:js_budget/src/fp/either.dart';
import 'package:js_budget/src/helpers/message.dart';
import 'package:js_budget/src/models/expense_model.dart';
import 'package:js_budget/src/models/material_model.dart';
import 'package:js_budget/src/modules/budget/budget_controller.dart';
import 'package:js_budget/src/modules/expenses/workshop_expenses/workshop_expense_controller.dart';
import 'package:js_budget/src/repositories/material/transform_material_json.dart';
import 'package:js_budget/src/repositories/material/material_repository.dart';
import 'package:js_budget/src/utils/utils_service.dart';
import 'package:signals/signals.dart';

class MaterialController with Messages {
  MaterialController({
    required MaterialRepository materialRepository,
  }) : _materialRepository = materialRepository;

  final _data = ListSignal<MaterialModel>([]);
  ListSignal get data => _data
    ..sort(
      (a, b) => a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase()),
    );

  final model = signal<MaterialModel?>(null);

  final MaterialRepository _materialRepository;

  Future<void> save(
    MaterialModel material,
    bool addMaterialValuesToStock,
    String? dateOfLastPurchase,
  ) async {
    final worshopController = Injector.get<WorkshopExpenseController>();
    final budgetController = Injector.get<BudgetController>();

    if (dateOfLastPurchase != null) {
      final date = UtilsService.getExtractedDate(dateOfLastPurchase);

      dateOfLastPurchase = UtilsService.dateFormatText(date);
    }

    final result = material.id == 0
        ? await _materialRepository.register(material)
        : await _materialRepository.update(
            material, addMaterialValuesToStock, dateOfLastPurchase);

    switch (result) {
      case Right(value: MaterialModel model):
        _data.add(model);
        worshopController.addData(_setDataMaterialInExpense(model));
        showSuccess('Material cadastrado com sucesso');
      case Right():
        if (material.id > 0) {
          _deleteItem(material.id);
        }
        _data.add(material);
        if (!addMaterialValuesToStock) {
          worshopController.updateData(
              _setDataMaterialInExpense(material), dateOfLastPurchase);
        } else {
          worshopController.addData(_setDataMaterialInExpense(material));
        }
        
        budgetController.changeMaterialListBudget(material);
        showSuccess('Material alterado com sucesso');
      case Left():
        showError('Houve um erro ao cadastrar o material');
    }
  }

  ExpenseModel _setDataMaterialInExpense(MaterialModel material) {
    final date = UtilsService.getExtractedDate(material.dateOfLastPurchase!);
    return ExpenseModel(
      description: material.name,
      value: material.lastQuantityAdded * material.price,
      date: UtilsService.dateFormatText(date),
      methodPayment: '',
      materialId: material.id,
      observation: 'Materiais para a produção',
    );
  }

  Future<void> deleteMaterial(int id) async {
    final result = await _materialRepository.delete(id);
    switch (result) {
      case Right():
        _deleteItem(id);
        showSuccess('Material excluido com sucesso');
      case Left():
        showError('Houve um erro ao excluir o material');
    }
  }

  void _deleteItem(int id) {
    _data.removeWhere((item) => item.id == id);
  }

  Future<void> findMaterials() async {
    _data.clear();
    final results = await _materialRepository.findAll();

    switch (results) {
      case Right(value: List<Map<String, dynamic>> materials):
        for (var material in materials) {
          _data.add(TransformMaterialJson.fromJson(material));
        }

      case Left():
        showError('Houver erro ao buscar os materiais');
    }
  }

  void decreaseQuantity(int quantity, int materiaId) {
    for (var data in _data) {
      if (data.id == materiaId) {
        data.quantity -= quantity;
        data.lastQuantityAdded -= quantity;
      }
    }
  }

  void increaseQuantity(int quantity, int materiaId) {
    for (var data in _data) {
      if (data.id == materiaId) {
        data.quantity += quantity;
        data.lastQuantityAdded += quantity;
      }
    }
  }
}
