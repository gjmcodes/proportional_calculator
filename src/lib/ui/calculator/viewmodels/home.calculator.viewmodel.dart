import 'package:shop_proportions/domain/calculator/entities/amount_unit.entity.dart';
import 'package:shop_proportions/domain/calculator/entities/measure_unit.entity.dart';
import 'package:shop_proportions/domain/calculator/entities/price_amount_unit.entity.dart';

class HomeCalculatorVM{

  double originalPrice;
  double originalAmount;
  double proportionalAmount;
  MeasureUnit selectedOriginalUnit;
  MeasureUnit selectedProportionalUnit;

  AmountUnit getOriginalAmount(){
    return AmountUnit(this.selectedOriginalUnit, this.originalAmount);
  }

  AmountUnit getDesiredAmount(){
    return AmountUnit(this.selectedProportionalUnit, proportionalAmount);
  }
  
  String getProportionalAmountString(){
    if(proportionalAmount == null) return "";
    return proportionalAmount.toStringAsFixed(2) + selectedProportionalUnit.value;
  }

  String getOriginalAmountString(){
    if(originalAmount == null) return "";
    return originalAmount.toStringAsFixed(2) + selectedOriginalUnit.value;
  }

  void changeSelectedOriginalUnit(MeasureUnit unit){
    this.selectedOriginalUnit = unit;
  }

  void changeSelectedProportionalUnit(MeasureUnit unit){
    this.selectedProportionalUnit = unit;
  }

  //RETURN
  double proportionalPrice;
  List<PriceAmountUnit> commonProportionalPrices;

  String proportionalPriceFixed(){
    if(proportionalPrice == null) return "";
    return proportionalPrice.toStringAsFixed(2);
  }

  bool hasProportionalPrice(){
    return this.proportionalPrice != null;
  }

  String getProportionalResult(){
    if(!hasProportionalPrice())return "";

    return this.getProportionalAmountString() +  " = R\$"
        + this.proportionalPriceFixed() + " de " + this.getOriginalAmountString();
  }
}