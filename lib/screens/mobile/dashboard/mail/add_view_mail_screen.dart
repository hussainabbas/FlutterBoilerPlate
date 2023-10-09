import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/widgets/text_view.dart';

class AddViewMailScreen extends ConsumerWidget {
  const AddViewMailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final argsIndex = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: TextView(
              text: argsIndex == -1 ? "New Mail" : "Mail",
              textColor: Colors.black,
              textFontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        body: Container());
  }
}
