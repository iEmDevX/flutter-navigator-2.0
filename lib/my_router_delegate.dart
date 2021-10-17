import 'package:flutter/material.dart';
import 'package:flutter_navigator2/color_datail.screen.dart';
import 'package:flutter_navigator2/color_list_screen.dart';
import 'package:flutter_navigator2/my_app_state.dart';
import 'package:flutter_navigator2/my_route.dart';
import 'package:flutter_navigator2/not_found_404_screen.dart';
import 'package:flutter_navigator2/route_configuration.dart';

class MyRouterDelegate extends RouterDelegate<RouteConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  late MyAppState state;

  MyRouterDelegate() {
    state = MyAppState();
    state.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    state.removeListener(notifyListeners);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  RouteConfiguration? get currentConfiguration {
    if (state.isNotFound) {
      return RouteConfiguration.notFound();
    } else {
      if (state.color != null) {
        return RouteConfiguration.detail(colorItem: state.color!);
      }
      return RouteConfiguration.home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) {
        return _handlePopPage(route, result);
      },
      pages: [
        MaterialPage(
          key: const ValueKey('page_home'),
          child: ColorListScreen(
            onColorItemSelected: (colorItem) {
              state.color = colorItem;
            },
          ),
        ),
        if (state.color != null)
          MaterialPage(
            key: const ValueKey('page_color_detail'),
            child: ColorDetailScreen(
              colorItem: state.color!,
            ),
          ),
        if (state.isNotFound)
          const MaterialPage(
            key: ValueKey('page_error'),
            child: NotFound404Screen(),
          ),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    if (configuration.isKnown) {
      if (configuration.route == MyRoutes.home) {
        state.isNotFound = false;
        state.color = null;
      } else if (configuration.route == MyRoutes.detail) {
        Map<String, dynamic> arguments = configuration.arguments;
        if (arguments.containsKey("color")) {
          var colorItem = arguments["color"];
          if (colorItem != null) {
            state.isNotFound = false;
            state.color = colorItem;
          }
        }
      }
    } else {
      state.isNotFound = true;
      state.color = null;
    }
  }

  bool _handlePopPage(Route route, result) {
    Page page = route.settings as Page;
    if (page.key == const ValueKey("page_home")) {
      return false;
    }

    route.didPop(result);

    if (page.key == const ValueKey("page_color_detail")) {
      state.color = null;
      return true;
    }
    if (page.key == const ValueKey("page_error")) {
      state.color = null;
      return true;
    }
    return false;
  }
}
