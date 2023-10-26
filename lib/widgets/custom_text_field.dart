import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.prefixIcon,
      required this.onChanged,
      this.errorMessage,
      this.obscure})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool? obscure;
  final String? errorMessage;
  final Icon prefixIcon;
  final ValueChanged<String> onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    bool obscureText = obscure ?? false;
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: title,
              icon: prefixIcon,
              suffixIcon: obscure ?? false ? IconButton(
                icon: Icon(
                  obscureText  ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                    console("asdsad - $obscureText - ${obscure}");
                  });
                },
              ): null,

            ),
            obscureText: obscureText && (obscure ?? false),
          ),
          const SizedBox(
            height: 8,
          ),
          if (errorMessage != null && errorMessage!.isNotEmpty)
            Text(
              errorMessage.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            )
          //TextView(text: errorMessage.toString(), textColor: Colors.red, textFontWeight: FontWeight.normal, fontSize: 12, align: TextAlign.start,)
        ],
      ),
    );
  }
}

*/
final obscureTextProvider = StateProvider<bool>((ref) => true);

class CustomTextField extends ConsumerWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.title,
      this.prefixIcon,
      this.isContainBottomBorder,
      required this.onChanged,
      this.errorMessage,
      this.keyboardType,
      this.obscure})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool? obscure;
  final String? errorMessage;
  final Icon? prefixIcon;
  final bool? isContainBottomBorder;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(builder: (context, ref, child) {
            var obscureProvider = ref.read(obscureTextProvider.notifier).state;
            return TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: keyboardType ?? TextInputType.text,
              decoration: InputDecoration(
                labelText: title,
                hintStyle: const TextStyle(fontSize: 12),
                border: isContainBottomBorder ?? true ? null : InputBorder.none,
                prefixIcon: prefixIcon,
                suffixIcon: obscure ?? false
                    ? IconButton(
                        icon: Icon(
                          obscureProvider
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          obscureProvider = !obscureProvider;
                        },
                      )
                    : null,
              ),
              obscureText: obscureProvider && (obscure ?? false),
            );
          }),
          const SizedBox(
            height: 8,
          ),
          if (errorMessage != null && errorMessage!.isNotEmpty)
            Text(
              errorMessage.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            )
          //TextView(text: errorMessage.toString(), textColor: Colors.red, textFontWeight: FontWeight.normal, fontSize: 12, align: TextAlign.start,)
        ],
      ),
    );
  }
}
