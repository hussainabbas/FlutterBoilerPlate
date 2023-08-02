import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final String imageAsset;
  final String bigText;
  final String smallText;

  const IntroPage({
    required this.imageAsset,
    required this.bigText,
    required this.smallText,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: kIsWeb ? 0.35 : 1.0,
      heightFactor: 1.0,
      child: Container(
        padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              bigText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white,)
            ),
            const SizedBox(height: 10),
            Text(
              smallText,
                textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)
            ),
          ],
        ),
      ),
    );
  }
}