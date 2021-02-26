import 'package:pricemob/domain/calculator/entities/price_calculator.root.dart';
import 'package:pricemob/ui/calculator/viewmodels/home.calculator.viewmodel.dart';

class HomeController{

  HomeCalculatorVM calculate(HomeCalculatorVM model){

    if(!model.isValid())return model;

    var _proportionalPrice = PriceCalculatorRoot.getPriceBetweenUnits(model.originalPrice,
        model.getOriginalAmount(), model.getDesiredAmount());
    model.proportionalPrice = _proportionalPrice;

    var _commonPrices = PriceCalculatorRoot.getCommonProportions(
        model.originalPrice, model.getOriginalAmount());
    model.commonProportionalPrices = _commonPrices;

    return model;
  }
}