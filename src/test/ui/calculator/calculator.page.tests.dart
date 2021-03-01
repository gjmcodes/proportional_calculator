

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pricemob/domain/calculator/entities/measure_unit.entity.dart';
import 'package:pricemob/main.dart';
import 'package:pricemob/ui/calculator/keys/keys.dart';
import 'package:pricemob/ui/calculator/pages/home.calculator.page.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('Unidade: -'), findsNWidgets(2));

    final sourceUnitSelector = find.byKey(Key(SOURCE_UNIT_SELECTOR_KEY));

    await tester.pump(Duration(seconds: 1));

    var listTileSheet = find.byKey(Key('select-list-' + MeasureUnit.kilogram.value));

    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(listTileSheet);

    await tester.pumpAndSettle(Duration(seconds: 2));

    final sourceUnitSelectorAfterTap = find.byKey(Key(SOURCE_UNIT_SELECTOR_KEY));
    final b = find.byType(OutlinedButton);

    final a = find.descendant(of: b.first,
        matching: find.byType(Text))
    .evaluate()
    .first;

    expect(find.text('Unidade: ' + MeasureUnit.kilogram.value), findsOneWidget);

  });
}