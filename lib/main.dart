import 'package:flutter/material.dart';

import 'app.dart';  
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dependencies = await initializeDependencies();

  runApp(
    App(
      dependencies: dependencies,
    ),
  );
}