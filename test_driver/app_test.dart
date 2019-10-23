import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable App', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if(driver != null) {
        await driver.close();
      }
    });
    test('verifies the list contains a specific item', () async {
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');
      await driver.scrollUntilVisible(listFinder, itemFinder, dyScroll: -300.0);
      expect(
        await driver.getText(itemFinder),
        'Item 50'
      );
    });
  });
}