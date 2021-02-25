import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shop_proportions/domain/calculator/entities/measure_unit.entity.dart';
import 'package:shop_proportions/ui/calculator/viewmodels/home.calculator.viewmodel.dart';

class InputCard extends StatefulWidget {
  final MoneyMaskedTextController priceSourceCtrl;
  final MoneyMaskedTextController amountSourceCtrl;
  final MoneyMaskedTextController amountProportionalCtrl;

  final HomeCalculatorVM viewModel;

  InputCard(this.viewModel, this.priceSourceCtrl, this.amountSourceCtrl,
      this.amountProportionalCtrl);

  @override
  _InputCardState createState() => _InputCardState(
      viewModel, priceSourceCtrl, amountSourceCtrl, amountProportionalCtrl);
}

class _InputCardState extends State<InputCard> {
  final MoneyMaskedTextController priceSourceCtrl;
  final MoneyMaskedTextController amountSourceCtrl;
  final MoneyMaskedTextController amountProportionalCtrl;

  HomeCalculatorVM viewModel;

  _InputCardState(this.viewModel, this.priceSourceCtrl, this.amountSourceCtrl,
      this.amountProportionalCtrl);

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

    priceSourceCtrl.addListener(_updatePriceSourceInput);
    amountSourceCtrl.addListener(_updateAmountSourceInput);
    amountProportionalCtrl.addListener(_updateAmountProportionalInput);

    super.initState();
  }

  void _updateSelectedUnit(int index) {
    setState(() {
      _selectedUnit = _units[index].value;
      viewModel.changeSelectedOriginalUnit(_units[index]);
    });
  }

  void _updateSelectedProportionalUnit(int index) {
    setState(() {
      _selectedProportionalUnit = _units[index].value;
      viewModel.changeSelectedProportionalUnit(_units[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                      child: Column(
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
                              SelectUnitDropDown(this._selectedUnit,
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
                              SelectUnitDropDown(this._selectedUnit, this._units
                                  , this._updateSelectedProportionalUnit),
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //CARD Top Row
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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

class SelectUnitDropDown extends StatefulWidget {
  final String selectedUnit;
  final List<MeasureUnit> measureUnits;
  final Function updateUnitCallback;

  SelectUnitDropDown(
      this.selectedUnit, this.measureUnits, this.updateUnitCallback);

  @override
  _SelectUnitDropDownState createState() => _SelectUnitDropDownState(
      this.selectedUnit, this.measureUnits, this.updateUnitCallback);
}

class _SelectUnitDropDownState extends State<SelectUnitDropDown> {
  String selectedUnit;
  List<MeasureUnit> measureUnits;
  Function updateUnitCallback;

  _SelectUnitDropDownState(
      this.selectedUnit, this.measureUnits, this.updateUnitCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: RaisedButton(
        onPressed: () {
          _showUnitsBottomSheet(context, measureUnits, updateUnitCallback);
        },
        child: Text('Unidade: $selectedUnit'),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(20.0)),
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ]
                ,
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
