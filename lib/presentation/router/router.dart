import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Tab,Route',
  generateForDir: ['lib/presentation'],
)
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: MainRoute.page,
      initial: true,
      children: [
        AutoRoute(page: CounterRoute.page, initial: true),
      ],
    ),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.material();
}

@RoutePage()
class MainPage extends AutoRouter {
  const MainPage({super.key});
}
