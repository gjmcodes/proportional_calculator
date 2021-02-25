import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shop_proportions/domain/calculator/entities/price_amount_unit.entity.dart';
import 'package:shop_proportions/ui/calculator/controllers/home_controller.calculator.dart';
import 'package:shop_proportions/ui/calculator/viewmodels/home.calculator.viewmodel.dart';
import 'package:shop_proportions/ui/calculator/widgets/input_card.calculator.dart';
import 'package:shop_proportions/ui/calculator/widgets/proportions_list_card.calculator.dart';

class HomeCalculator extends StatefulWidget {
  @override
  _HomeCalculatorState createState() => _HomeCalculatorState();
}

class _HomeCalculatorState extends State<HomeCalculator> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  var viewModel = new HomeCalculatorVM();
  final homeController = new HomeController();
  AdmobBannerSize bannerSize;

  //TextControllers
  final TextEditingController priceSourceCtrl = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
  final TextEditingController amountSourceCtrl =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final TextEditingController amountProportionalCtrl =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  String proportionalPrice = "";
  List<PriceAmountUnit> proportionalPrices = <PriceAmountUnit>[];

  _calculate() {
    setState(() {
      FocusScope.of(context).unfocus();

      this.viewModel = homeController.calculate(viewModel);
      this.proportionalPrice = viewModel.proportionalPriceFixed();
      this.proportionalPrices = viewModel.commonProportionalPrices;
    });
  }

  String getTopBannerId() {
    if (Platform.isIOS) {
      return null;
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6801501942748732/7605927008';
    }
    return null;
  }

  String getBottomBannerId(){
    if (Platform.isIOS) {
      return null;
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6801501942748732/9218391573';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Calculadora de Proporções'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         /* AdmobBanner(
            adUnitId: getTopBannerId(),
            adSize: AdmobBannerSize.ADAPTIVE_BANNER(
              width: MediaQuery.of(context).size.width.toInt(),
            ),
          ), */
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blueGrey[50],
              child: ListView(
                children: [
                  Container(
                    width: 250,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: InputCard(
                                  this.viewModel,
                                  this.priceSourceCtrl,
                                  this.amountSourceCtrl,
                                  this.amountProportionalCtrl),
                            ), //CARD Container

                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 16.5, 0.0),
                              child: Container(
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ButtonTheme(
                                      minWidth:
                                          MediaQuery.of(context).size.width /
                                              2.3,
                                      height: 50,
                                      child: RaisedButton(
                                        child: const Icon(Icons.add),
                                        onPressed: () {
                                          this._calculate();
                                        },
                                      ),
                                    ),
                                  )),
                            ), //BUTTON
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Builder(
                          builder: (context) {
                            if (this.viewModel.commonProportionalPrices ==
                                    null ||
                                viewModel.commonProportionalPrices.length <= 0)
                              return Container();

                            return Container(
                                width: double.infinity,
                                height: (100 * this.proportionalPrices.length)
                                    .toDouble(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new ProportionsListCard(
                                      priceProportion: this.proportionalPrices),
                                ));
                          },
                        ),
                      ), //List
                    ]),
                  )
                ],
              ),
            ),
          ),
         /* AdmobBanner(
            adUnitId: getBottomBannerId(),
            adSize: AdmobBannerSize.ADAPTIVE_BANNER(
              width: MediaQuery.of(context).size.width.toInt(),
            ),
          ), */
        ],
      ),
    );
  }
}
