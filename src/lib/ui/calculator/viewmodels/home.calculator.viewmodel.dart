import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:pricemob/domain/calculator/entities/amount_unit.entity.dart';
import 'package:pricemob/domain/calculator/entities/measure_unit.entity.dart';
import 'package:pricemob/domain/calculator/entities/price_amount_unit.entity.dart';
import 'package:pricemob/ui/@currency/currency_services.dart';

class HomeCalculatorVM{

  double originalPrice = 0.0;
  double originalAmount = 0.0;
  double proportionalAmount = 0.0;
  MeasureUnit selectedOriginalUnit;
  MeasureUnit selectedProportionalUnit;

  //TextControllers
  MoneyMaskedTextController priceSourceCtrl;
  MoneyMaskedTextController amountSourceCtrl;
  MoneyMaskedTextController amountProportionalCtrl;

  HomeCalculatorVM(){
    this.priceSourceCtrl =
        CurrencyServices.getMoneyMaskedTextController();
    this.amountSourceCtrl =
        CurrencyServices.getFormattedTextController();
    this.amountProportionalCtrl =
        CurrencyServices.getFormattedTextController();
  }

  bool isValid(){
    return this.originalPrice > 0
        && this.selectedProportionalUnit != null
        && this.selectedOriginalUnit != null
        && this.originalAmount > 0
        && this.proportionalAmount > 0;
  }
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

  void reset(){
    this.originalPrice = 0.0;
    this.proportionalAmount = 0.0;
    this.originalAmount = 0.0;
    this.selectedOriginalUnit = null;
    this.selectedProportionalUnit = null;
    this.proportionalPrice = 0.0;
    this.commonProportionalPrices = null;
    this.priceSourceCtrl.text = "0.0";
    this.amountSourceCtrl.text = "0.0";
    this.amountProportionalCtrl.text = "0.0";
  }
  //RETURN
  double proportionalPrice;
  List<PriceAmountUnit> commonProportionalPrices;

  String proportionalPriceFixed(){
    if(proportionalPrice == null) return "";
    return proportionalPrice.toStringAsFixed(2);
  }

  bool hasProportionalPrice(){
    return this.proportionalPrice != null
    && this.proportionalAmount != null
    && this.selectedProportionalUnit != null
    && this.selectedOriginalUnit != null;
  }

  String getProportionalResult(){
    if(!hasProportionalPrice())return "";

    return this.getProportionalAmountString() +  " = R\$"
        + this.proportionalPriceFixed() + " de " + this.getOriginalAmountString();
  }
}