import 'package:flutter/material.dart';
import 'package:shop_app/Model/PageViewModel.dart';
  Widget PageViewItem ({
  required PageViewModel? model, required BuildContext context ,
  }
  ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Center(child: Image(width: 350,height:300,image: AssetImage("assets/images/im${model?.imagenumber}.jpg")))),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text("${model?.title}",style: Theme.of(context).textTheme.bodyText1),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Text("${model?.disc}",style:Theme.of(context).textTheme.bodyText2 ,
          maxLines: 2),
        ),
      ],
    );

}
