import 'package:auto_route/auto_route.dart';
import 'package:counter/core/utils/utils.dart';

import '../config/log_config.dart';
import '../utils/log_utils.dart';

class LogNavigatorObserver extends AutoRouterObserver {
  LogNavigatorObserver();

  bool get _enableLog => LogConfig.enableNavigatorObserverLog;

  @override
  void didPush(route, previousRoute) {
    super.didPush(route, previousRoute);
    if (_enableLog) {
      Log.d('didPush from ${previousRoute?.settings.name} to ${route.settings.name}');
    }
  }

  @override
  void didPop(route, previousRoute) {
    super.didPop(route, previousRoute);
    if (_enableLog) {
      Log.d('didPop ${route.settings.name}, back to ${previousRoute?.settings.name}');
    }
  }

  @override
  void didRemove(route, previousRoute) {
    super.didRemove(route, previousRoute);
    if (_enableLog) {
      Log.d('didRemove ${route.settings.name}, back to ${previousRoute?.settings.name}');
    }
  }

  @override
  void didReplace({newRoute, oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_enableLog) {
      Log.d('didReplace ${oldRoute?.settings.name} by ${newRoute?.settings.name}');
    }
  }
}
