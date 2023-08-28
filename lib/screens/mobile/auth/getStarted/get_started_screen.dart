import 'package:app_name/helpers/resources/colors.dart';
import 'package:app_name/helpers/resources/image_resources.dart';
import 'package:app_name/helpers/resources/routes_resources.dart';
import 'package:app_name/screens/mobile/auth/getStarted/get_started_bloc.dart';
import 'package:app_name/widgets/intro_page.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late GetStartedBloc _bloc;
  late PageController _pageController;
  int _currentPage = 0;
  final List<Widget> _pages = [
    const IntroPage(
      imageAsset: ImageResources.slide1,
      bigText: 'My Life, My Way',
      smallText:
          'Choose when, how and who provides your support at home and in community.',
    ),
    const IntroPage(
      imageAsset: ImageResources.slide2,
      bigText: "You're In Control With app_name",
      smallText: 'Start exploring now',
    ),
    const IntroPage(
      imageAsset: ImageResources.slide3,
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

    _pageController.addListener(() {
      int currentPage = _pageController.page?.round() ?? 0;
      _bloc.updatePage(currentPage);
      _currentPage = currentPage;
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
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
                    return _pages[index % _pages.length];
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
                          Navigator.pushNamed(context, Routes.loginScreen);
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
                          activeColor: primaryColor, // Active dot color
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          } else {
                            Navigator.pushNamed(context, Routes.loginScreen);
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
          }),
    );
  }
}
