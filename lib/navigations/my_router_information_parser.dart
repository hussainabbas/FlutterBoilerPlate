import 'package:flutter/cupertino.dart';
import 'package:manawanui/navigations/my_router_path.dart';

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.uri;
    return MyRoutePath.parse(routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    return RouteInformation(location: path.toUrl());
  }
}
