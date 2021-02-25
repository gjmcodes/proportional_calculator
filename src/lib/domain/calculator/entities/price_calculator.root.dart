import 'package:shop_proportions/domain/calculator/entities/measure_unit.entity.dart';
import 'package:shop_proportions/domain/calculator/entities/price_amount_unit.entity.dart';

import 'amount_unit.entity.dart';

class PriceCalculatorRoot {
  static final commonMassProportions = {
    new AmountUnit(MeasureUnit.gram, 50.00),
    new AmountUnit(MeasureUnit.gram, 100.00),
    new AmountUnit(MeasureUnit.gram, 500.00),
    new AmountUnit(MeasureUnit.kilogram, 1.0),
    new AmountUnit(MeasureUnit.kilogram, 2.5),
    new AmountUnit(MeasureUnit.kilogram, 5.0),
  };

  static final commonVolumeProportions = {
    new AmountUnit(MeasureUnit.milliliter, 50.00),
    new AmountUnit(MeasureUnit.milliliter, 100.00),
    new AmountUnit(MeasureUnit.milliliter, 250.00),
    new AmountUnit(MeasureUnit.milliliter, 500.00),
    new AmountUnit(MeasureUnit.liter, 1.00),
    new AmountUnit(MeasureUnit.liter, 1.50),
    new AmountUnit(MeasureUnit.liter, 2.00),
    new AmountUnit(MeasureUnit.liter, 3.00),
  };

  static double calculateProportionalPrice(
      double sourcePrice, double sourceAmount, proportionalAmount) {
    return (sourcePrice * proportionalAmount) / sourceAmount;
  }

  static double getPriceBetweenUnits(double originalPrice,
      AmountUnit originalAmountUnit, AmountUnit desiredAmountUnit) {

    //get proportional price
    if (originalAmountUnit.isSameUnit((desiredAmountUnit.unit))) {
      return PriceCalculatorRoot.crossMultiplication(
          originalAmountUnit.amount, originalPrice, desiredAmountUnit.amount);
    }

    //convert to same unit
    var desiredConvertedUnitAmount = MeasureUnit.convertAmount(
        desiredAmountUnit.amount,
        desiredAmountUnit.unit,
        originalAmountUnit.unit);

    return PriceCalculatorRoot.crossMultiplication(
        originalAmountUnit.amount, originalPrice, desiredConvertedUnitAmount);
  }

  static double crossMultiplication(
      double valueA, double valueB, double valueC) {
    return (valueB * valueC) / valueA;
  }

  static List<PriceAmountUnit> getCommonProportions(
    double originalPrice, AmountUnit originalAmount) {
    var _amountProportions = <PriceAmountUnit>[];

    var commonProportions = originalAmount.isMass()
        ? PriceCalculatorRoot.commonMassProportions
        : PriceCalculatorRoot.commonVolumeProportions;

    commonProportions.forEach((element) {
      var _proportionalPrice = PriceCalculatorRoot.getPriceBetweenUnits(
          originalPrice, originalAmount, element);
      var priceAmount = PriceAmountUnit(_proportionalPrice, element);
      _amountProportions.add(priceAmount);
    });

    return _amountProportions;
  }
}
