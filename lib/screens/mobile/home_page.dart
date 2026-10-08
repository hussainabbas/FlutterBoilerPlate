import 'package:flutter/material.dart';
import 'package:manawanui/config/config.dart';
import 'package:manawanui/widgets/responsive_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, isMobile, isWeb) {
      return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).colorScheme.background,
        //   title: Text(widget.title),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppConfig.of(context)?.flavorName ?? "",
                style: isMobile
                    ? Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.red)
                    : Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.green),
              ),
              Text(
                AppConfig.of(context)?.baseUrl ?? "",
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
