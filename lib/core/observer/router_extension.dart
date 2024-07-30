import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' as m;

const double _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

extension RouterExtension on StackRouter {
  Future<T?> showDialog<T>({
    required m.WidgetBuilder builder,
    bool barrierDismissible = true,
    m.Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    m.RouteSettings? routeSettings,
    m.Offset? anchorPoint,
    m.TraversalEdgeBehavior? traversalEdgeBehavior,
  }) async =>
      navigatorKey.currentContext?.mounted == true ?
      m.showDialog<T>(
        context: navigatorKey.currentContext!,
        builder: builder,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
        traversalEdgeBehavior: traversalEdgeBehavior,
      ) : null;


  Future<T?> showModalBottomSheet<T>({
    required m.WidgetBuilder builder,
    m.Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    m.ShapeBorder? shape,
    m.Clip? clipBehavior,
    m.BoxConstraints? constraints,
    m.Color? barrierColor,
    bool isScrollControlled = false,
    double scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    m.RouteSettings? routeSettings,
    m.AnimationController? transitionAnimationController,
    m.Offset? anchorPoint,
    m.AnimationStyle? sheetAnimationStyle,
  }) async =>
      navigatorKey.currentContext?.mounted == true ?
      m.showModalBottomSheet<T>(
        context: navigatorKey.currentContext!,
        builder: builder,
        backgroundColor: backgroundColor,
        barrierLabel: barrierLabel,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        useSafeArea: useSafeArea,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
        sheetAnimationStyle: sheetAnimationStyle,
      ) : null;
}