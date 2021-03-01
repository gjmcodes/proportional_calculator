import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:pricemob/ui/@currency/currency_services.dart';
import 'package:pricemob/ui/calculator/keys/keys.dart';
import 'package:provider/provider.dart';
import 'package:pricemob/domain/calculator/entities/price_amount_unit.entity.dart';
import 'package:pricemob/ui/@stores/calculator.store.dart';
import 'package:pricemob/ui/calculator/controllers/home_controller.calculator.dart';
import 'package:pricemob/ui/calculator/viewmodels/home.calculator.viewmodel.dart';
import 'package:pricemob/ui/calculator/widgets/input_card.calculator.dart';
import 'package:pricemob/ui/calculator/widgets/proportions_list_card.calculator.dart';

import '../../../AppLocalizations.dart';

class HomeCalculator extends StatefulWidget {
  @override
  _HomeCalculatorState createState() => _HomeCalculatorState();
}

class _HomeCalculatorState extends State<HomeCalculator> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  final homeController = new HomeController();
  HomeCalculatorVM viewModel;
  CalculatorStore calculatorStore;

  String proportionalPrice = "";
  List<PriceAmountUnit> proportionalPrices = <PriceAmountUnit>[];

  void calculate() {
    setState(() {
      FocusScope.of(context).unfocus();

      this.calculatorStore.viewModel = homeController.calculate(this.calculatorStore.viewModel);
      this.proportionalPrice = this.calculatorStore.viewModel.proportionalPriceFixed();
      this.proportionalPrices = this.calculatorStore.viewModel.commonProportionalPrices;
    });
  }

  void reset(){
    setState(() {
      this.calculatorStore.resetCalculator();
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
    CurrencyServices.setCurrencyFormat(context);

    this.calculatorStore = Provider.of<CalculatorStore>(context);
    this.calculatorStore.buildViewModel();

    this.viewModel = calculatorStore.viewModel;



    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            /*AdmobBanner(
              key: Key(ADS_TOP_BANNER_KEY),
              adUnitId: getTopBannerId(),
              adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                width: MediaQuery.of(context).size.width.toInt(),
              ),
            ),*/
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueGrey[50],
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(children: [
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: InputCard(
                                  this.viewModel,
                                  this.calculate,
                                  this.reset),
                            ), //CARD Container
                         //BUTTON
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Builder(
                            builder: (context) {
                              if (this.calculatorStore.viewModel.commonProportionalPrices ==
                                      null ||
                                  this.calculatorStore.viewModel.commonProportionalPrices.length <= 0)
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
              key: Key(ADS_BOTTOM_BANNER_KEY),
              adUnitId: getBottomBannerId(),
              adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                width: MediaQuery.of(context).size.width.toInt(),
              ),
            ) ,*/
          ],
        ),
      ),
    );
  }
}
