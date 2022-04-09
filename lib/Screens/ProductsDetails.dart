import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopStates.dart';


class ProductsDetails extends StatefulWidget {
int productsId ;
  ProductsDetails({required this.productsId});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
       ShopCubit cubit =ShopCubit.get(context);
       cubit.getProductsDetails(id: widget.productsId);

          return Scaffold(
            appBar: AppBar(
              title: Text("ProductsDetails"),
              centerTitle: true,
              elevation: 1,
            ),
            body:(cubit.productDetailsmodel != null)?
            Stack(
              alignment: Alignment.bottomCenter,
           children: [
             SingleChildScrollView(
               child: Container(
                 height: MediaQuery.of(context).size.height,
                 child:Column(
                   children: [
                     Hero(
                       tag: "${cubit.productDetailsmodel?.data!.id}",
                       child: Stack(
                         alignment: Alignment.bottomRight,
                         children: [
                           Image(
                             image: NetworkImage("${cubit.productDetailsmodel?.data!.image}"),
                             height: MediaQuery.of(context).size.height / 3,
                           ),
                           (cubit.productDetailsmodel?.data!.discount != 0)?Text("DISCOUNT",style: TextStyle(
                               color: Colors.white,
                               backgroundColor: Colors.red,
                               fontSize: 20
                           ),
                           ):SizedBox(),
                         ],
                       ),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text("${cubit.productDetailsmodel?.data!.name}",
                           style: Theme.of(context).textTheme.bodyText1),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(right: 10,left: 10),
                       child: Row(
                         children: [
                           Text(
                             "${cubit.productDetailsmodel?.data!.price}\$",
                             style: TextStyle(
                                 color: Theme.of(context).accentColor,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 30),
                           ),
                           SizedBox(
                             width: 20,
                           ),
                           (cubit.productDetailsmodel?.data!.discount != 0)
                               ? Text(
                             "${cubit.productDetailsmodel?.data!.oldPrice}\$",
                             style: TextStyle(
                                 color: Colors.grey,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20,
                                 decoration: TextDecoration.lineThrough),
                           )
                               : SizedBox(),
                         ],
                       ),
                     ),
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Text(
                           "${cubit.productDetailsmodel?.data!.description}",
                           style: TextStyle(
                             overflow: TextOverflow.visible,
                           ),
                         ),
                       ),
                     ),

                   ],
                 ) ,
               )
               ,
             ),
             MaterialButton(
               onPressed: () {
                 cubit.ChangeCart(cubit.productDetailsmodel?.data!.id);
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     (cubit.productDetailsmodel?.data!.inCart!.toString() == "true")?
                     "Remove From Cart" :"Add To Cart",
                     style: TextStyle(
                         color: Colors.black, fontSize: 20, fontFamily: "Font1"),
                   ),
                 ],
               ),
               color: Theme.of(context).accentColor,
               minWidth: double.infinity,
               height: 50,
             ),
           ],
            ) :
                Center(
                  child: CircularProgressIndicator(color: Colors.grey,),
                )

          );

        },

      ),
      );

  }
}
