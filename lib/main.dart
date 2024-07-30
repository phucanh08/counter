import 'package:counter/di/di.dart';
import 'package:flutter/material.dart';

import 'presentation/app/app.dart';

void main() {
  configureDependencies();
  runApp(const App());
}
