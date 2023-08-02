import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FlutterBoilerPlater/helpers/models/DrawerItem.dart';
import 'package:FlutterBoilerPlater/helpers/resources/colors.dart';
import 'package:FlutterBoilerPlater/screens/dashboard/drawer/DrawerItemsBloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: BlocProvider(
        create: (_) => DrawerItemsBloc()..fetchDrawerItems(),
        child: BlocBuilder<DrawerItemsBloc, List<DrawerItem>>(
          builder: (context, drawerItems) {
            return ListView.separated(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildDrawerHeader(context);
                } else {
                  final item = drawerItems[index];
                  return ListTile(
                    //leading: Icon(item.icon),
                    title: Text(item.name),
                    onTap: () {
                      // Handle item tap
                    },
                  );
                }
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.white, // Set your desired background color here
      ),
      accountName: Text('John Doe' , style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),),
      accountEmail: Text('Employer', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black)),
      currentAccountPicture: const CircleAvatar(
        backgroundImage: NetworkImage('https://example.com/profile.jpg'),
      ),
    );
  }
}