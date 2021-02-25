import 'package:mobx/mobx.dart';
import 'package:shop_proportions/domain/calculator/entities/measure_unit.entity.dart';

part 'calculator.store.g.dart';

class CalculatorStore = _CalculatorStore with _$CalculatorStore;

abstract class _CalculatorStore with Store{
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

  @action
  changeSelectedOriginalUnit(MeasureUnit unit){
    this.selectedOriginalUnit = unit;
  }

  @action
  changeSelectedProportionalUnit(MeasureUnit unit){
    this.selectedProportionalUnit = unit;
  }


}