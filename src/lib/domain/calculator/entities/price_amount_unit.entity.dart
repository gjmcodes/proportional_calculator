import 'package:pricemob/domain/calculator/entities/amount_unit.entity.dart';

class PriceAmountUnit{
  double price;
  AmountUnit amountUnit;

  PriceAmountUnit(this.price, this.amountUnit);

  String getPrice(){
    return price.toStringAsFixed(2);
  }

  String getAmountPerUnit(){
    return amountUnit.amount.toStringAsFixed(2) + " / " + amountUnit.unit.value;
  }
}