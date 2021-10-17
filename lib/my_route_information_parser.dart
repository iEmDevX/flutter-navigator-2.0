import 'package:flutter/material.dart';
import 'package:flutter_navigator2/color_data.dart';
import 'package:flutter_navigator2/color_item.dart';
import 'package:flutter_navigator2/my_route.dart';
import 'package:flutter_navigator2/route_configuration.dart';

class MyRouteInformationParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    var uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return RouteConfiguration.home();
    } else if (uri.pathSegments.length == 2 && uri.pathSegments[0] == "colors") {
      ColorItem? colorItem = ColorData.getByTitle(uri.pathSegments[1]);
      if (colorItem != null) {
        return RouteConfiguration(route: MyRoutes.detail, arguments: {"color": colorItem});
      }
    }

    return RouteConfiguration.notFound();
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfiguration configuration) {
    if (configuration.isKnown) {
      if (configuration.route == MyRoutes.home) {
        return const RouteInformation(location: "/");
      }
      if (configuration.route == MyRoutes.detail) {
        if (configuration.arguments.containsKey("color")) {
          ColorItem? colorItem = configuration.arguments["color"];
          if (colorItem != null) {
            return RouteInformation(location: "/colors/${colorItem.title}");
          }
        }
      }
    }
    return const RouteInformation(location: "/404NotFound");
  }
}
