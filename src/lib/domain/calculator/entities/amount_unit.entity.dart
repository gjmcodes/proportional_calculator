import 'package:pricemob/domain/calculator/entities/measure_unit.entity.dart';
import 'package:pricemob/domain/calculator/enums/measure_unit_type.enum.dart';

class AmountUnit{
  MeasureUnit unit;
  double amount;

  AmountUnit(this.unit, this.amount);

  bool isSameUnit(MeasureUnit unit){
    return this.unit.key == unit.key;
  }

  bool isMass(){
    return this.unit.type == MeasureUnitType.MASS;
  }

  bool isVolume(){
    return this.unit.type == MeasureUnitType.VOLUME;
  }

  String getUnit(){
    return unit.value;
  }
}