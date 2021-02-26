import 'dart:math';

import 'package:pricemob/domain/calculator/enums/measure_unit_type.enum.dart';

const CONVERTION_BASE_MULTIPLIER = 10;
const CONVERTION_UNIT_MULTIPLIER = 3;

class MeasureUnit {
  int key;
  String value;
  MeasureUnitType type;

  MeasureUnit(this.key, this.value, this.type);

  static double convertAmount(
      double amount, MeasureUnit fromUnit, MeasureUnit toUnit) {
    if (fromUnit.key == toUnit.key) return amount;

    final absIndexDiff =
        (max(fromUnit.key, toUnit.key) - min(fromUnit.key, toUnit.key).abs());

    //Converting to higher unit
    if (fromUnit.key < toUnit.key) {
      return amount /
          pow(CONVERTION_BASE_MULTIPLIER,
              CONVERTION_UNIT_MULTIPLIER * absIndexDiff);
    }

    //converting to lower unit
    if (fromUnit.key > toUnit.key) {
      return amount *
          pow(CONVERTION_BASE_MULTIPLIER,
              CONVERTION_UNIT_MULTIPLIER * absIndexDiff);
    }

    return 0;
  }

  //INTERNATIONAL UNITS
  static final MeasureUnit milligram =
      MeasureUnit(0, 'mg', MeasureUnitType.MASS);

  static final MeasureUnit gram = MeasureUnit(1, 'g', MeasureUnitType.MASS);

  static final MeasureUnit kilogram = MeasureUnit(2, 'kg', MeasureUnitType.MASS);

  static final MeasureUnit milliliter =
      MeasureUnit(3, 'mL', MeasureUnitType.VOLUME);

  static final MeasureUnit liter = MeasureUnit(4, 'L', MeasureUnitType.VOLUME);

  static final  List<MeasureUnit> internationalUnits = [
    MeasureUnit.milligram,
    MeasureUnit.gram,
    MeasureUnit.kilogram,
    MeasureUnit.milliliter,
    MeasureUnit.liter
  ];

}
