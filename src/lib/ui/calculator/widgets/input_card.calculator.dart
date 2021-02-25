import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:shop_proportions/domain/calculator/entities/measure_unit.entity.dart';
import 'package:shop_proportions/ui/@stores/calculator.store.dart';
import 'package:shop_proportions/ui/calculator/viewmodels/home.calculator.viewmodel.dart';

class InputCard extends StatefulWidget {
  final MoneyMaskedTextController priceSourceCtrl;
  final MoneyMaskedTextController amountSourceCtrl;
  final MoneyMaskedTextController amountProportionalCtrl;

  final HomeCalculatorVM viewModel;
  final Function calculateCallback;

  InputCard(this.viewModel, this.priceSourceCtrl, this.amountSourceCtrl,
      this.amountProportionalCtrl, this.calculateCallback);

  @override
  _InputCardState createState() => _InputCardState(viewModel, priceSourceCtrl,
      amountSourceCtrl, amountProportionalCtrl, calculateCallback);
}

class _InputCardState extends State<InputCard> {
  final MoneyMaskedTextController priceSourceCtrl;
  final MoneyMaskedTextController amountSourceCtrl;
  final MoneyMaskedTextController amountProportionalCtrl;

  final HomeCalculatorVM viewModel;
  final Function calculateCallback;

  CalculatorStore calculatorStore;

  _InputCardState(this.viewModel, this.priceSourceCtrl, this.amountSourceCtrl,
      this.amountProportionalCtrl, this.calculateCallback);

  final List<MeasureUnit> _units = MeasureUnit.internationalUnits;

  String _selectedUnit = "";
  String _selectedProportionalUnit = "";

  _updatePriceSourceInput() {
    if (priceSourceCtrl.text != null && priceSourceCtrl.text != "")
      viewModel.originalPrice = priceSourceCtrl.numberValue;
  }

  _updateAmountSourceInput() {
    if (amountSourceCtrl.text != null && amountSourceCtrl.text != "")
      viewModel.originalAmount = amountSourceCtrl.numberValue;
  }

  _updateAmountProportionalInput() {
    if (amountProportionalCtrl.text != null &&
        amountProportionalCtrl.text != "")
      viewModel.proportionalAmount = amountProportionalCtrl.numberValue;
  }

  @override
  void initState() {
    _selectedUnit = "-";
    _selectedProportionalUnit = "-";

    priceSourceCtrl.addListener(_updatePriceSourceInput);
    amountSourceCtrl.addListener(_updateAmountSourceInput);
    amountProportionalCtrl.addListener(_updateAmountProportionalInput);

    super.initState();
  }

  String _updateSelectedUnit(int index) {
    setState(() {
      var unit = _units[index];

      _selectedUnit = unit.value;
      viewModel.changeSelectedOriginalUnit(unit);
      this.calculatorStore.changeSelectedOriginalUnit(unit);
    });
    return _selectedUnit;
  }

  void _updateSelectedProportionalUnit(int index) {
    setState(() {
      var unit = _units[index];
      _selectedProportionalUnit = unit.value;
      viewModel.changeSelectedProportionalUnit(unit);
      this.calculatorStore.changeSelectedProportionalUnit(unit);
    });
  }

  @override
  Widget build(BuildContext context) {
    this.calculatorStore = Provider.of<CalculatorStore>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(7.5, 0.0, 7.5, 0.0),
      child: Column(
        children: [
          Container(
            height: 375,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                InfoCircle('R\$'),
                                CardTextInput(
                                  'Valor do produto',
                                  priceSourceCtrl,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InfoCircle(_selectedUnit),
                                CardTextInput(
                                  'Medida',
                                  amountSourceCtrl,
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                                OriginalUnitButton(
                                    this._units, this._updateSelectedUnit),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InfoCircle(_selectedProportionalUnit),
                                CardTextInput(
                                  'Medida de comparação',
                                  amountProportionalCtrl,
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                                ProportionalUnitButton(this._units,
                                    this._updateSelectedProportionalUnit),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: new BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InfoCircle(
                                      '$_selectedUnit / R\$',
                                      width: 62.5,
                                      height: 62.5,
                                    ),
                                    CardReadOnlyText(
                                      'Preço proporcional',
                                      this.viewModel.getProportionalResult(),
                                      width: MediaQuery.of(context).size.width / 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ), //CARD Top Row
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Container(
                      child: ElevatedButton(
                          onPressed: () {
                            this.calculateCallback();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0)
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calculate,
                                  color: Colors.white),
                              const Text(
                                'calcular',
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCircle extends StatelessWidget {
  final String selectedUnit;
  final double width;
  final double height;
  InfoCircle(this.selectedUnit, {this.width = 30, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
          width: this.width,
          height: this.height,
          child: Center(child: Text(selectedUnit)),
          decoration:
              new BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
    );
  }
}

class OriginalUnitButton extends StatefulWidget {
  final List<MeasureUnit> measureUnits;
  final Function updateUnitCallback;

  OriginalUnitButton(this.measureUnits, this.updateUnitCallback);

  @override
  _OriginalUnitButtonState createState() =>
      _OriginalUnitButtonState(this.measureUnits, this.updateUnitCallback);
}

class _OriginalUnitButtonState extends State<OriginalUnitButton> {
  final List<MeasureUnit> measureUnits;
  final Function updateUnitCallback;

  _OriginalUnitButtonState(this.measureUnits, this.updateUnitCallback);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<CalculatorStore>(context);
    String selectedUnit = store.selectedOriginalUnit?.value;

    return SelectUnitDropDown(
        selectedUnit, this.measureUnits, this.updateUnitCallback);
  }
}

class ProportionalUnitButton extends StatefulWidget {
  final List<MeasureUnit> measureUnits;
  final Function updateUnitCallback;

  ProportionalUnitButton(this.measureUnits, this.updateUnitCallback);

  @override
  _ProportionalUnitButtonState createState() =>
      _ProportionalUnitButtonState(this.measureUnits, this.updateUnitCallback);
}

class _ProportionalUnitButtonState extends State<ProportionalUnitButton> {
  final List<MeasureUnit> measureUnits;
  final Function updateUnitCallback;

  _ProportionalUnitButtonState(this.measureUnits, this.updateUnitCallback);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<CalculatorStore>(context);
    String selectedUnit = store.selectedProportionalUnit?.value;

    return SelectUnitDropDown(
        selectedUnit, this.measureUnits, this.updateUnitCallback);
  }
}

class SelectUnitDropDown extends StatelessWidget {
  final String selectedUnit;
  final List<MeasureUnit> measureUnits;
  final Function updateUnitCallback;

  SelectUnitDropDown(
      this.selectedUnit, this.measureUnits, this.updateUnitCallback);

  @override
  Widget build(BuildContext context) {
    var _text = selectedUnit == null ? "-" : selectedUnit;
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: OutlinedButton(
        onPressed: () {
          _showUnitsBottomSheet(context, measureUnits, updateUnitCallback);
        },
        child: Text('Unidade: $_text'),
      ),
    );
  }
}

class CardReadOnlyText extends StatelessWidget {
  final String label;
  final String textValue;
  final double width;

  CardReadOnlyText(this.label, this.textValue, {Key key, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.label,
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Text(this.textValue,
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class CardTextInput extends StatelessWidget {
  final String hint;
  final double width;
  final bool readonly;
  final TextEditingController controller;

  CardTextInput(this.hint, this.controller,
      {Key key, this.width, this.readonly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.hint),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: TextField(
                readOnly: this.readonly,
                controller: this.controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: this.readonly ? Colors.white38 : Colors.black54,
                  fontWeight:
                      this.readonly ? FontWeight.bold : FontWeight.normal,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0)),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showUnitsBottomSheet(
    context, List<MeasureUnit> units, Function updateCallback) {
  Widget _buildListTile(BuildContext context, int index) {
    return Container(
      height: 50,
      child: ListTile(
        leading: Icon(Icons.add),
        title: Center(child: Text(units[index].value)),
        onTap: () {
          updateCallback(index);
          Navigator.pop(context);
        },
      ),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
    );
  }

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: ListView.builder(
            itemCount: units.length,
            itemBuilder: _buildListTile,
          ),
        );
      });
}
