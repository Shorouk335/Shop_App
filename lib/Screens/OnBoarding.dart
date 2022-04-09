import 'package:flutter/material.dart';
import 'package:shop_app/Model/PageViewModel.dart';
import 'package:shop_app/Shared/Components/PageViewItem.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Shared/Constants/Constants.dart';

class OnBoarding extends StatelessWidget {
  var controller =PageController();

  int indexPageView = 0;

  List PageViewData = [
    PageViewModel(imagenumber: 1, title: "Hello to Shop App", disc: "you can now shop online and whenever you want"),
    PageViewModel(imagenumber: 2, title: "Easy Shopping", disc: "you can buy whatever you want at the best prices"),
    PageViewModel(imagenumber: 3, title: "Delivery Speed", disc: "you will receive your order as soon as possible"),
  ];

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: (){
                OnBoardingTrue(context);
              }, child: Text("SKIP",style: Theme.of(context).textTheme.button)),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context ,index)=> PageViewItem(model: PageViewData[index], context: context),
                  itemCount:PageViewData.length ,
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index){
                    indexPageView = index ;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SmoothPageIndicator(
                      count: PageViewData.length,
                      controller: controller ,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Theme.of(context).accentColor,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                      onPressed: (){
                        if (indexPageView == PageViewData.length-1 ){
                          OnBoardingTrue(context);
                        }
                        controller.nextPage(duration: Duration(milliseconds: 750,),
                            curve: Curves.fastLinearToSlowEaseIn);
                      },
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),

        );
  }
}
