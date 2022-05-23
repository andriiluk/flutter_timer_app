import 'dart:convert';
import 'package:app/models/models.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalTimerRepository {
  LocalTimerRepository({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;
  late TimerEntity _timerEntity;

  static const collectionKey = '__timer_entities__';
  void _init() {
    final jsonString = _plugin.getString(collectionKey);
    if (jsonString == null) {
      _timerEntity = TimerEntity(title: 'New Timer');
      return;
    }

    _timerEntity =
        TimerEntity.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

  TimerEntity getEntity() {
    return _timerEntity;
  }
}
