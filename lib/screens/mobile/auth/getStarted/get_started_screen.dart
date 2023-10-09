import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/image_resources.dart';
import 'package:manawanui/helpers/resources/routes_resources.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/screens/mobile/auth/getStarted/get_started_bloc.dart';
import 'package:manawanui/widgets/intro_page.dart';
import 'package:manawanui/widgets/responsive_widget.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key, required this.flavor}) : super(key: key);

  final String flavor;

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late GetStartedBloc _bloc;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  final int _autoPageChangeDuration = 2;

  final List<Widget> _pages = [
    const IntroPage(
      imageAsset: ImageResources.SLIDE1,
      bigText: 'My Life, My Way',
      smallText:
          'Choose when, how and who provides your support at home and in community.',
    ),
    const IntroPage(
      imageAsset: ImageResources.SLIDE2,
      bigText: "You're In Control With manawanui",
      smallText: 'Start exploring now',
    ),
    const IntroPage(
      imageAsset: ImageResources.SLIDE3,
      bigText: "It's Your Life, You Choose",
      smallText:
          'Set your budget, check your expenditure and monitor your funding balances all in one easy place.',
    ),
  ];
  final List<Widget> _pagesMLMW = [
    const IntroPage(
      imageAsset: ImageResources.SLIDE1,
      bigText: 'My Life, My Way',
      smallText:
          'Choose when, how and who provides your support at home and in community.',
    ),
    const IntroPage(
      imageAsset: ImageResources.SLIDE2,
      bigText: "You're In Control With My Life, My Way",
      smallText: 'Start exploring now',
    ),
    const IntroPage(
      imageAsset: ImageResources.SLIDE3,
      bigText: "It's Your Life, You Choose",
      smallText:
          'Set your budget, check your expenditure and monitor your funding balances all in one easy place.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _bloc = GetStartedBloc();
    _pageController = PageController();
    _startAutoPageChange();
    _pageController.addListener(() {
      int currentPage = _pageController.page?.round() ?? 0;
      _bloc.updatePage(currentPage);
      _currentPage = currentPage;
    });
  }

  void _startAutoPageChange() {
    _timer = Timer.periodic(
      Duration(seconds: _autoPageChangeDuration),
      (timer) {
        if (_currentPage <
            (widget.flavor == StringResources.MLMW
                ? _pagesMLMW.length - 1
                : _pages.length - 1)) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        } else {
          _pageController.jumpToPage(0);
        }
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, isMobile, isWeb) {
      if (isMobile) {
        // Mobile: Take up 100% width and height
        return Scaffold(body: buildGetStartedScreen());
      } else {
        return Scaffold(
            body: Stack(
          children: [
            Image.asset(
              ImageResources.SPLASH_BG,
              fit: BoxFit.cover,
              height: context.fullWidth(),
              width: context.fullHeight(),
            ),
            Center(
              child: SizedBox(
                width: context.fullWidth(multiplier: 0.3),
                height: context.fullHeight(multiplier: 0.9),
                child: buildGetStartedScreen(),
              ),
            ),
          ],
        ));
      }
    });
  }

  Widget buildGetStartedScreen() {
    return StreamBuilder<int>(
        stream: _bloc.currentPageStream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          int currentPage = snapshot.data ?? 0;
          _currentPage = currentPage;
          return Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => _bloc.updatePage(index),
                itemBuilder: (BuildContext context, int index) {
                  if (widget.flavor == StringResources.MLMW) {
                    return _pagesMLMW[index % _pagesMLMW.length];
                  } else {
                    return _pages[index % _pages.length];
                  }
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        // var a = {
                        //   "id":"100",
                        //   "name":"asdsad"
                        // };

                        //context.go("${Routes.LOGIN_SCREEN}/$a");
                        GoRouter.of(context).go(Routes.LOGIN_SCREEN);
                        //Navigator.pushNamed(context, Routes.LOGIN_SCREEN);
                      },
                      child: Text('Skip',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white)),
                    ),
                    DotsIndicator(
                      dotsCount: _pages.length,
                      position: _currentPage,
                      decorator: DotsDecorator(
                        color: Colors.grey, // Inactive dot color
                        activeColor: AppColors.primaryColor, // Active dot color
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (currentPage < _pages.length - 1) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else {
                          context.push(Routes.LOGIN_SCREEN);
                          //Navigator.pushNamed(context, Routes.LOGIN_SCREEN);
                        }
                      },
                      child: Text(
                          currentPage < _pages.length - 1 ? 'Next' : 'Done',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
