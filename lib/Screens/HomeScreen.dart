import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/ShopDataModel.dart';
import 'package:shop_app/Shared/Components/FlutterToAstItem.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopStates.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context, state){
        if (state is SuccessChangeFavoritesState){
          if (state.changeFavoritesModel!.status!){
            FlutterToAstItem(txt: state.changeFavoritesModel!.message!, state:ToastStates.SUCCESS );

          }else {
            FlutterToAstItem(txt: state.changeFavoritesModel!.message!, state:ToastStates.ERROR );
          }
        }

      },
     builder: (context,state){
        ShopCubit  cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.shopDataModel != null && cubit.categoriesDataModel != null,
            builder: (context)=> SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSliderWidget(cubit,context),
                  SizedBox(height: 10,),
                  Center(child: AnimatedSmoothIndicator(
                    effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).accentColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 2,
                      spacing: 5,
                    ),
                    activeIndex:cubit.indexCarouselSider,
                    count:cubit.shopDataModel!.data!.banners.length,
                   ) ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Categories",style:TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: "Font1",
                    ),),
                  ),
                  CategoriesDataWidget(cubit ,context),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Products",style:TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: "Font1",
                    ),),
                  ),
                  GridViewWidget(cubit,context),
                ],
              ),
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator(color: Colors.grey,))) ;
     },
    );
  }
  Widget CarouselSliderWidget(ShopCubit cubit , context){
    return  CarouselSlider(
        items: cubit.shopDataModel!.data!.banners.map((e)=>
            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                image: DecorationImage(
                  image: NetworkImage("${e.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ), ).toList(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          onPageChanged: ((index, reason) {
            cubit.ChangeindexCarouselSider(index);
          }),
          viewportFraction: 0.98,
          autoPlay: true,
          height: MediaQuery.of(context).size.height/5,
          initialPage: cubit.indexCarouselSider,
          enableInfiniteScroll: false ,
          reverse: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ));
  }
  Widget CategoriesDataWidget (ShopCubit cubit , context){
    return Container(
      width: double.infinity,
      height:MediaQuery.of(context).size.height/5,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder:(context ,index ){
              return Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(image: NetworkImage("${cubit.categoriesDataModel!.categoriesData!.data[index].image}"),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width/2,),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    color: Colors.black.withOpacity(0.8) ,
                    child: Text("  ${cubit.categoriesDataModel!.categoriesData!.data[index].name}",style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontFamily: "Font1"
                    ),),
                  ),

                ],
              );
            } ,
            separatorBuilder:(context ,index )=> SizedBox(width: 5,child: Container(color: Colors.grey[300],)),
            itemCount: cubit.categoriesDataModel!.categoriesData!.data.length),
    );
  }
  Widget GridViewWidget(ShopCubit cubit ,context){
    return Container(
      color: Colors.grey[300],
      child: GridView.count(
          crossAxisCount: 2,
           children: List.generate(
               cubit.shopDataModel!.data!.products.length, (index) {
             return  ProductsWidget(cubit ,cubit.shopDataModel!.data!.products[index] ,context) ;
           }) ,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.4,
          shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),



      ),
    );
  }
  Widget ProductsWidget(ShopCubit cubit ,Products data ,context){
    return InkWell(
      onTap: (){
        NavigateToProductsDetails(context ,data.id!);
      },
      child: Container(
         color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Hero(
                  tag: "${data.id}",
                  child: Image(
                    image: NetworkImage("${data.image}"),
                    height:200,
                    width: 200,
                  ),
                ),
                (data.discount !=0)?Text("DISCOUNT",style: TextStyle(
                  backgroundColor: Colors.red,
                  color: Colors.white,
                  fontSize: 15,
                ),):SizedBox(),
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text("${data.name}",style:TextStyle(
                fontSize: 17,
                color: Colors.black,
                overflow: TextOverflow.ellipsis
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                children: [
                  Text("${data.price}\$" ,style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),),
                 SizedBox(width: 5,),
                 (data.discount !=0)?
                  Text("${data.old_price}" ,style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      decoration: TextDecoration.lineThrough

                  ),) : SizedBox() ,
                  Spacer(),
                  IconButton(onPressed: (){
                    cubit.changeFavorites(data.id);
                  },
                      icon: (cubit.FavoriteList[data.id]!)?Icon( Icons.favorite ,size: 30,) :Icon(Icons.favorite_border)  ,
                      color: (cubit.FavoriteList[data.id]!)? Colors.red : Colors.grey ,
                      )
                ],
              ),
            )

          ],
        ),
      ),
    );

  }

}
