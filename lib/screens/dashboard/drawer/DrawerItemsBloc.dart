import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FlutterBoilerPlater/helpers/models/DrawerItem.dart';

class DrawerItemsBloc extends Cubit<List<DrawerItem>> {
  //final ApiProvider apiProvider;

  //DrawerItemsBloc(this.apiProvider) : super([]);
  DrawerItemsBloc() : super([]);
  final List<DrawerItem> _item = <DrawerItem>[
  DrawerItem(name: "Default", id: "0"),
  DrawerItem(name: "Statement", id: "1"),
  DrawerItem(name: "Budgeting", id: "2"),
  DrawerItem(name: "Payees", id: "3"),
  DrawerItem(name: "Timesheet", id: "4"),
  DrawerItem(name: "Announcements", id: "5"),
  DrawerItem(name: "Mail", id: "6"),
  ];


  void fetchDrawerItems() async {
    try {
      // Fetch data from the API using the ApiProvider

      final drawerItems = _item;
      //final drawerItems = await apiProvider.fetchDrawerItems();

      // Update the state with the fetched data
      emit(drawerItems);
    } catch (error) {
      // Handle any errors that occur during API request
      // Emit an error state or take appropriate action
    }
  }
}