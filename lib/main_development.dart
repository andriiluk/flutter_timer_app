// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:app/app/app.dart';
import 'package:app/bootstrap.dart';
import 'package:app/repositories/timer/timer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final timerRepository = LocalTimerRepository(
    plugin: await SharedPreferences.getInstance(),
  );

  await bootstrap(
    () => App(
      timerRepository: timerRepository,
    ),
  );
}
