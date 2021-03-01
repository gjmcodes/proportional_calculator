import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:pricemob/domain/calculator/entities/measure_unit.entity.dart';
import 'package:pricemob/ui/@currency/currency_services.dart';
import 'package:pricemob/ui/calculator/viewmodels/home.calculator.viewmodel.dart';

part 'calculator.store.g.dart';

class CalculatorStore = _CalculatorStore with _$CalculatorStore;

abstract class _CalculatorStore with Store {
  @observable
  double originalPrice = 0.0;

  @observable
  double originalAmount = 0.0;

  @observable
  double proportionalAmount = 0.0;

  @observable
  MeasureUnit selectedOriginalUnit;

  @observable
  MeasureUnit selectedProportionalUnit;

  @observable
  TextEditingController priceSourceCtrl;

  @observable
  TextEditingController amountSourceCtrl;

  @observable
  TextEditingController amountProportionalCtrl;

  @observable
  HomeCalculatorVM viewModel;

  @action
  buildViewModel() {
    if (this.viewModel == null) {
      this.viewModel = new HomeCalculatorVM();
    }
  }

  @action
  changeSelectedOriginalUnit(MeasureUnit unit) {
    this.viewModel.selectedOriginalUnit = unit;
  }

  @action
  changeSelectedProportionalUnit(MeasureUnit unit) {
    this.viewModel.selectedProportionalUnit = unit;
  }

  @action
  resetCalculator() {
    this.viewModel.reset();
  }
}
