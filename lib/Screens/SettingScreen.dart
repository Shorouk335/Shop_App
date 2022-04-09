import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Components/FlutterToAstItem.dart';
import 'package:shop_app/Shared/Components/TextFormItem.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopStates.dart';
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var FormKey= GlobalKey<FormState>();

    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (BuildContext context , state){
        if (state is SuccessUPDateProfileDataState){
          if(state.userDateModel!.status!){
            FlutterToAstItem(txt: state.userDateModel!.message!, state: ToastStates.SUCCESS);
            ShopCubit.get(context).getProfileData();
          }else{
            FlutterToAstItem(txt: state.userDateModel!.message!, state: ToastStates.ERROR);
          }
        }
      } ,
      builder: (context ,state) {
        ShopCubit cubit = ShopCubit.get(context);
        nameController.text = cubit.profileModel!.data!.name! ;
        emailController.text = cubit.profileModel!.data!.email!;
        phoneController.text = cubit.profileModel!.data!.phone!;
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height /1.3,
            child:  Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        TextFormWidget(
                          context: context,
                          txt: "name",
                          preficon: Icons.account_circle,
                          Control: nameController ,
                        ),
                        SizedBox(height: 20,),
                        TextFormWidget(
                          context: context,
                          txt: "email",
                          preficon: Icons.email,
                          Control: emailController,
                        ),
                        SizedBox(height: 20,),
                        TextFormWidget(
                          context: context,
                          txt: "phone",
                          preficon: Icons.phone,
                          Control: phoneController,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (FormKey.currentState!.validate())
                          {
                            cubit.UpdateProfile(name: nameController.text, email: emailController.text, phone: phoneController.text);

                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          SignOut(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

            ) ,
          ),

        );


      },
    );
  }
}
