// import 'package:app/models/models.dart';
import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Json encoding/decoding TimerEntity object', () {
    final entity = TimerEntity(
      title: 'Test entity',
      items: [
        TimerItem(title: 'item1', duration: const Duration(seconds: 5)),
      ],
    )
      ..title = 'New Title'
      ..items
          .add(TimerItem(title: 'Item2', duration: const Duration(seconds: 5)));

    final encoded = jsonEncode(entity);
    final decodedItem =
        TimerEntity.fromJson(json.decode(encoded) as Map<String, dynamic>);

    debugPrint('Encoded: $encoded');
    debugPrint('decodedItem: $decodedItem');

    final newEncoded = jsonEncode(decodedItem);
    expect(encoded, newEncoded);
  });
}
