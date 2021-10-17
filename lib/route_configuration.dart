import 'package:flutter_navigator2/color_item.dart';
import 'package:flutter_navigator2/my_route.dart';

class RouteConfiguration {
  late MyRoutes route;
  late Map<String, dynamic> arguments;

  RouteConfiguration({this.route = MyRoutes.home, Map<String, dynamic>? arguments}) {
    this.arguments = arguments ?? {};
  }

  RouteConfiguration.home() {
    route = MyRoutes.home;
    arguments = {};
  }

  RouteConfiguration.detail({required ColorItem colorItem}) {
    route = MyRoutes.detail;
    arguments = {"color": colorItem};
  }

  RouteConfiguration.notFound() {
    route = MyRoutes.notFound;
    arguments = {};
  }

  bool get isKnown {
    return route != MyRoutes.notFound;
  }
}
