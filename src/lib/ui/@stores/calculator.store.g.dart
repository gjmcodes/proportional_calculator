// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalculatorStore on _CalculatorStore, Store {
  final _$originalPriceAtom = Atom(name: '_CalculatorStore.originalPrice');

  @override
  double get originalPrice {
    _$originalPriceAtom.reportRead();
    return super.originalPrice;
  }

  @override
  set originalPrice(double value) {
    _$originalPriceAtom.reportWrite(value, super.originalPrice, () {
      super.originalPrice = value;
    });
  }

  final _$originalAmountAtom = Atom(name: '_CalculatorStore.originalAmount');

  @override
  double get originalAmount {
    _$originalAmountAtom.reportRead();
    return super.originalAmount;
  }

  @override
  set originalAmount(double value) {
    _$originalAmountAtom.reportWrite(value, super.originalAmount, () {
      super.originalAmount = value;
    });
  }

  final _$proportionalAmountAtom =
      Atom(name: '_CalculatorStore.proportionalAmount');

  @override
  double get proportionalAmount {
    _$proportionalAmountAtom.reportRead();
    return super.proportionalAmount;
  }

  @override
  set proportionalAmount(double value) {
    _$proportionalAmountAtom.reportWrite(value, super.proportionalAmount, () {
      super.proportionalAmount = value;
    });
  }

  final _$selectedOriginalUnitAtom =
      Atom(name: '_CalculatorStore.selectedOriginalUnit');

  @override
  MeasureUnit get selectedOriginalUnit {
    _$selectedOriginalUnitAtom.reportRead();
    return super.selectedOriginalUnit;
  }

  @override
  set selectedOriginalUnit(MeasureUnit value) {
    _$selectedOriginalUnitAtom.reportWrite(value, super.selectedOriginalUnit,
        () {
      super.selectedOriginalUnit = value;
    });
  }

  final _$selectedProportionalUnitAtom =
      Atom(name: '_CalculatorStore.selectedProportionalUnit');

  @override
  MeasureUnit get selectedProportionalUnit {
    _$selectedProportionalUnitAtom.reportRead();
    return super.selectedProportionalUnit;
  }

  @override
  set selectedProportionalUnit(MeasureUnit value) {
    _$selectedProportionalUnitAtom
        .reportWrite(value, super.selectedProportionalUnit, () {
      super.selectedProportionalUnit = value;
    });
  }

  final _$priceSourceCtrlAtom = Atom(name: '_CalculatorStore.priceSourceCtrl');

  @override
  TextEditingController get priceSourceCtrl {
    _$priceSourceCtrlAtom.reportRead();
    return super.priceSourceCtrl;
  }

  @override
  set priceSourceCtrl(TextEditingController value) {
    _$priceSourceCtrlAtom.reportWrite(value, super.priceSourceCtrl, () {
      super.priceSourceCtrl = value;
    });
  }

  final _$amountSourceCtrlAtom =
      Atom(name: '_CalculatorStore.amountSourceCtrl');

  @override
  TextEditingController get amountSourceCtrl {
    _$amountSourceCtrlAtom.reportRead();
    return super.amountSourceCtrl;
  }

  @override
  set amountSourceCtrl(TextEditingController value) {
    _$amountSourceCtrlAtom.reportWrite(value, super.amountSourceCtrl, () {
      super.amountSourceCtrl = value;
    });
  }

  final _$amountProportionalCtrlAtom =
      Atom(name: '_CalculatorStore.amountProportionalCtrl');

  @override
  TextEditingController get amountProportionalCtrl {
    _$amountProportionalCtrlAtom.reportRead();
    return super.amountProportionalCtrl;
  }

  @override
  set amountProportionalCtrl(TextEditingController value) {
    _$amountProportionalCtrlAtom
        .reportWrite(value, super.amountProportionalCtrl, () {
      super.amountProportionalCtrl = value;
    });
  }

  final _$viewModelAtom = Atom(name: '_CalculatorStore.viewModel');

  @override
  HomeCalculatorVM get viewModel {
    _$viewModelAtom.reportRead();
    return super.viewModel;
  }

  @override
  set viewModel(HomeCalculatorVM value) {
    _$viewModelAtom.reportWrite(value, super.viewModel, () {
      super.viewModel = value;
    });
  }

  final _$_CalculatorStoreActionController =
      ActionController(name: '_CalculatorStore');

  @override
  dynamic buildViewModel() {
    final _$actionInfo = _$_CalculatorStoreActionController.startAction(
        name: '_CalculatorStore.buildViewModel');
    try {
      return super.buildViewModel();
    } finally {
      _$_CalculatorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSelectedOriginalUnit(MeasureUnit unit) {
    final _$actionInfo = _$_CalculatorStoreActionController.startAction(
        name: '_CalculatorStore.changeSelectedOriginalUnit');
    try {
      return super.changeSelectedOriginalUnit(unit);
    } finally {
      _$_CalculatorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSelectedProportionalUnit(MeasureUnit unit) {
    final _$actionInfo = _$_CalculatorStoreActionController.startAction(
        name: '_CalculatorStore.changeSelectedProportionalUnit');
    try {
      return super.changeSelectedProportionalUnit(unit);
    } finally {
      _$_CalculatorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetCalculator() {
    final _$actionInfo = _$_CalculatorStoreActionController.startAction(
        name: '_CalculatorStore.resetCalculator');
    try {
      return super.resetCalculator();
    } finally {
      _$_CalculatorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
originalPrice: ${originalPrice},
originalAmount: ${originalAmount},
proportionalAmount: ${proportionalAmount},
selectedOriginalUnit: ${selectedOriginalUnit},
selectedProportionalUnit: ${selectedProportionalUnit},
priceSourceCtrl: ${priceSourceCtrl},
amountSourceCtrl: ${amountSourceCtrl},
amountProportionalCtrl: ${amountProportionalCtrl},
viewModel: ${viewModel}
    ''';
  }
}
