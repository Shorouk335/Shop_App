import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopStates.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesDataModel != null,
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            color: Colors.grey,
          )),
          builder: (context) {
            return ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Colors.grey.shade100,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width /2.3,
                              height: MediaQuery.of(context).size.height / 5,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.grey.shade100,
                              ),
                              child: Image(
                                image: NetworkImage(
                                  "${cubit.categoriesDataModel!.categoriesData!.data[index].image}",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("${cubit.categoriesDataModel!.categoriesData!.data[index].name}",style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black ,
                            fontFamily: "Font1"
                          ),),
                          Spacer(),
                          Icon(Icons.arrow_back_ios,color: Colors.black),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                itemCount:
                    cubit.categoriesDataModel!.categoriesData!.data.length);
          },
        );
      },
    );
  }
}
