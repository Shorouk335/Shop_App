import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/SearchCubit/SearchCubit.dart';
import 'package:shop_app/Shared/Cubit/SearchCubit/SearchStates.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopCubit.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 1,
                  title: Text("Search"),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: txtController,
                        cursorColor: Theme.of(context).accentColor,
                        decoration: InputDecoration(
                          iconColor: Theme.of(context).accentColor,
                          labelText: "Search",
                          labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).accentColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          cubit.GetSearch(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ConditionalBuilder(
                          condition: cubit.searchModel != null,
                          builder: (context) => ListView.separated(
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        color: Colors.grey.shade100,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0)),
                                                  color: Colors.grey.shade100,
                                                ),
                                                child: Image(
                                                  image: NetworkImage(
                                                    "${cubit.searchModel!.data!.data![index].image}",
                                                  ),
                                                ),
                                              )),
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "${cubit.searchModel!.data!.data![index].name}",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                "${cubit.searchModel!.data!.data![index].price}\$",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: IconButton(
                                              icon: (cubit
                                                      .searchModel!
                                                      .data!
                                                      .data![index]
                                                      .inFavorites!)
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                      size: 30,
                                                    )
                                                  : Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.grey,
                                                      size: 30,
                                                    ),
                                              onPressed: () {
                                                ShopCubit.get(context)
                                                    .changeFavorites(cubit
                                                        .searchModel!
                                                        .data!
                                                        .data![index]
                                                        .id);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 5,
                                  ),
                              itemCount: cubit.searchModel!.data!.data!.length),
                          fallback: (context) =>Center(child: CircularProgressIndicator(color: Colors.grey,),)),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
