import 'package:flutter/material.dart';
import 'package:pricemob/domain/calculator/entities/price_amount_unit.entity.dart';

class ProportionsListCard extends StatelessWidget {
  final List<PriceAmountUnit> priceProportion;
  ProportionsListCard({this.priceProportion});

  List<Widget> _buildProportionsList() {
    List<Widget> list = <Widget>[];
    for (var proportion in this.priceProportion) {
      list.add(Column(children: [
        ListTile(
          title: Text(
            proportion.getAmountPerUnit(),
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          subtitle: Row(children: [
            Icon(Icons.monetization_on),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'R\$' + proportion.getPrice(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ]),
        ),
        const Divider(
          color: Colors.blueGrey,
          height: 5,
          thickness: 2,
          indent: 10,
          endIndent: 10,
        ),
      ]));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {

    var _widgets = <Widget>[];
    _widgets.add(
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          width: double.infinity,
          child: const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: const Text(
                'Preços Propocionais Comuns',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
    _widgets.addAll(_buildProportionsList());

    return Card(
        child: Column(
      children: _widgets,
    ));
  }
}
