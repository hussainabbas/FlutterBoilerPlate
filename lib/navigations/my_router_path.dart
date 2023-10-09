import 'package:manawanui/helpers/resources/routes_resources.dart';

class MyRoutePath {
  final String route;
  final String? dynamicParam; // Add a dynamic parameter field

  MyRoutePath.splash()
      : route = Routes.SPLASH_SCREEN,
        dynamicParam = null;

  MyRoutePath.getStarted()
      : route = Routes.GET_STARTED_SCREEN,
        dynamicParam = null;

  MyRoutePath.home()
      : route = Routes.HOME_ROUTE,
        dynamicParam = null;

  // Define constructors for other routes as needed

  // Constructor for a route with a dynamic parameter
  MyRoutePath.withDynamicParam(this.route, this.dynamicParam);

  // Add a method to parse the current path into a MyRoutePath object
  static MyRoutePath parse(String? location) {
    final uri = Uri.parse(location ?? '');
    final segments = uri.pathSegments;

    if (segments.isEmpty) {
      return MyRoutePath.home();
    }

    final route = segments[0];

    if (route == Routes.HOME_ROUTE) {
      if (segments.length > 1) {
        final dynamicParam = segments[1];
        return MyRoutePath.withDynamicParam(route, dynamicParam);
      } else {
        return MyRoutePath.home();
      }
    }

    // Implement parsing logic for other routes as needed
    // Handle unknown routes appropriately
    return MyRoutePath.home();
  }

  // Add a method to serialize the current MyRoutePath object to a string
  String toUrl() {
    if (route == Routes.HOME_ROUTE && dynamicParam != null) {
      return '/$route/$dynamicParam';
    } else {
      return '/$route';
    }
  }
}
