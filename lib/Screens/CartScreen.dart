import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopStates.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return  BlocProvider(
      create: (BuildContext context)=> ShopCubit()..getCartData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){} ,
        builder: (context,state){
          var cubit =ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("MY Cart"),
              centerTitle: true,
              elevation: 1,
            ),
            body : ConditionalBuilder(
              condition: cubit.cartModel != null,
              builder:(context)=> ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>
                    Padding(
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
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width /2.5,
                                    height: MediaQuery.of(context).size.height / 5,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                        "${cubit.cartModel!.data!.cartItems![index].product!.image}",
                                      ),
                                    ),
                                  ),
                                  (cubit.cartModel!.data!.cartItems![index].product!.discount != 0)?
                                  (
                                      Text("DISCOUNT",style: TextStyle(
                                          color: Colors.white ,
                                          backgroundColor: Colors.red,
                                          fontSize: 15
                                      ),)
                                  ):(SizedBox())
                                ],

                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${cubit.cartModel!.data!.cartItems![index].product!.name}",style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black ,
                                  ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text("${cubit.cartModel!.data!.cartItems![index].product!.price}\$",style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red ,
                                      ),),
                                      SizedBox(width: 5,),
                                      (cubit.cartModel!.data!.cartItems![index].product!.discount != 0)?
                                      Text("${cubit.cartModel!.data!.cartItems![index].product!.oldPrice}",style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey ,
                                        decoration: TextDecoration.lineThrough,
                                      ),):(SizedBox())

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: IconButton(
                                icon: Icon(Icons.delete,color: Colors.grey,size: 30,),
                                onPressed: (){
                                  cubit.ChangeCart(cubit.cartModel!.data!.cartItems![index].product!.id);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context,index)=> SizedBox(
                  height: 5,
                ),
                itemCount: cubit.cartModel!.data!.cartItems!.length,

              ),
              fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.grey,),) ,
            ) ,
          );
        },

      ),
    );

  }
}
