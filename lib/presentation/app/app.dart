import 'package:flutter/material.dart';

import '../../core/observer/navigator_observer.dart';
import '../router/router.dart';

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      routerConfig: appRouter.config(
        navigatorObservers: () => [LogNavigatorObserver()]
      ),
      theme: ThemeData.dark(),
    );
  }

}
