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

  final _$_CalculatorStoreActionController =
      ActionController(name: '_CalculatorStore');

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
  String toString() {
    return '''
originalPrice: ${originalPrice},
originalAmount: ${originalAmount},
proportionalAmount: ${proportionalAmount},
selectedOriginalUnit: ${selectedOriginalUnit},
selectedProportionalUnit: ${selectedProportionalUnit}
    ''';
  }
}
