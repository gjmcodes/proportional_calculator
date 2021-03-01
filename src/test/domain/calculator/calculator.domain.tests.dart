import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pricemob/domain/calculator/entities/amount_unit.entity.dart';
import 'package:pricemob/domain/calculator/entities/measure_unit.entity.dart';
import 'package:pricemob/domain/calculator/entities/price_calculator.root.dart';

void main(){
  testWidgets('Can convert price between different units with same amount', (WidgetTester tester) async {

    final AmountUnit sourceUnit = AmountUnit(MeasureUnit.kilogram, 1);
    final AmountUnit desiredUnit = AmountUnit(MeasureUnit.gram, 500);

    final double sourcePrice = 10.0;

    var priceResult = PriceCalculatorRoot.getPriceBetweenUnits(sourcePrice,
        sourceUnit, desiredUnit);

    final double expectedDesiredPrice = 5.0;
    expect(expectedDesiredPrice, priceResult);

  });

  testWidgets('Can convert price between same units with different amount', (WidgetTester tester) async {

    final AmountUnit sourceUnit = AmountUnit(MeasureUnit.kilogram, 1);
    final AmountUnit desiredUnit = AmountUnit(MeasureUnit.kilogram, 5);

    final double sourcePrice = 10.0;

    var priceResult = PriceCalculatorRoot.getPriceBetweenUnits(sourcePrice,
        sourceUnit, desiredUnit);

    final double expectedDesiredPrice = 50.0;
    expect(expectedDesiredPrice, priceResult);

  });

  testWidgets('Can convert price between same units with fractional amount', (WidgetTester tester) async {

    final AmountUnit sourceUnit = AmountUnit(MeasureUnit.kilogram, 1.3);
    final AmountUnit desiredUnit = AmountUnit(MeasureUnit.kilogram, 2.5);

    final double sourcePrice = 10.0;

    var priceResult = PriceCalculatorRoot.getPriceBetweenUnits(sourcePrice,
        sourceUnit, desiredUnit).toStringAsFixed(2);

    final String expectedDesiredPrice = (19.23).toStringAsFixed(2);
    expect(expectedDesiredPrice, priceResult);

  });

  testWidgets('Can convert price between different units with fractional amount', (WidgetTester tester) async {

    final AmountUnit sourceUnit = AmountUnit(MeasureUnit.kilogram, 1.3);
    final AmountUnit desiredUnit = AmountUnit(MeasureUnit.gram, 2000.50);

    final double sourcePrice = 10.0;

    var priceResult = PriceCalculatorRoot.getPriceBetweenUnits(sourcePrice,
        sourceUnit, desiredUnit).toStringAsFixed(2);

    final String expectedDesiredPrice = (15.39).toStringAsFixed(2);
    expect(expectedDesiredPrice, priceResult);

  });


}