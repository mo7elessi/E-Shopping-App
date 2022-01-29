import 'package:e_shopping/modules/user/login/tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/network/local/cache_helper.dart';
import 'package:e_shopping/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingModel {
  final String image;
  final String title;
  final String description;

  onBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLastView = false;
    List<onBoardingModel> onBoard = [
      onBoardingModel(
        image: 'assets/images/onBoard1.jpg',
        title: 'Feature 1',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      ),
      onBoardingModel(
        image: 'assets/images/onBoard2.jpg',
        title: 'Feature 2',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      ),
      onBoardingModel(
        image: 'assets/images/onBoard3.jpg',
        title: 'Feature 3',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      ),
    ];
    var pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        actions: [
          defaultTextButton(
            text: '',
            btnName: 'Skip',
            function: () {
              CacheHelper.saveData(key: 'onBoarding', value: true).then(
                (value) {
                  if (value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Tabs(),
                      ),
                      (route) {
                        return false;
                      },
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'welcome'.toUpperCase(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return buildPageViewItem(onBoard[index]);
                  },
                  itemCount: onBoard.length,
                  onPageChanged: (index) {
                    if (index == onBoard.length - 1) {
                      setState(() {
                        isLastView = true;
                      });
                    } else {
                      setState(() {
                        isLastView = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: primaryColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: onBoard.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLastView) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Tabs(),
                          ),
                          (route) {
                            return false;
                          },
                        );
                      } else {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    backgroundColor: primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageViewItem(onBoardingModel model) {
    return Column(
      children: [
        Image(
          image: AssetImage(model.image),
          width: 300.0,
          height: 300.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 60.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text(
          '${model.description}',
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
