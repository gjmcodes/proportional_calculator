import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:shop_proportions/domain/calculator/entities/price_amount_unit.entity.dart';
import 'package:shop_proportions/ui/@stores/calculator.store.dart';
import 'package:shop_proportions/ui/calculator/controllers/home_controller.calculator.dart';
import 'package:shop_proportions/ui/calculator/viewmodels/home.calculator.viewmodel.dart';
import 'package:shop_proportions/ui/calculator/widgets/input_card.calculator.dart';
import 'package:shop_proportions/ui/calculator/widgets/proportions_list_card.calculator.dart';

const String DECIMAL_SEPARATOR = ",";
const String THOUSAND_SEPARATOR =".";

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
      decimalSeparator: DECIMAL_SEPARATOR, thousandSeparator: THOUSAND_SEPARATOR, leftSymbol: 'R\$');
  final TextEditingController amountSourceCtrl =
      MoneyMaskedTextController(decimalSeparator: DECIMAL_SEPARATOR, thousandSeparator: THOUSAND_SEPARATOR);
  final TextEditingController amountProportionalCtrl =
      MoneyMaskedTextController(decimalSeparator: DECIMAL_SEPARATOR, thousandSeparator: THOUSAND_SEPARATOR);

  String proportionalPrice = "";
  List<PriceAmountUnit> proportionalPrices = <PriceAmountUnit>[];

  void calculate() {
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
                    width: double.infinity,
                    child: Column(children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: InputCard(
                                this.viewModel,
                                this.priceSourceCtrl,
                                this.amountSourceCtrl,
                                this.amountProportionalCtrl,
                                this.calculate),
                          ), //CARD Container
                       //BUTTON
                        ],
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
