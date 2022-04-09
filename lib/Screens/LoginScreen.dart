import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Components/FlutterToAstItem.dart';
import 'package:shop_app/Shared/Components/TextFormItem.dart';
import '../Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/LoginCubit/LoginCubit.dart';
import 'package:shop_app/Shared/Cubit/LoginCubit/LoginStates.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool hidePassword = true ;
  IconData PasswordIcon =Icons.visibility_off ;
 var FormKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context )=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates> (
        listener: (context, state) {
           if (state is SuccessLoginState){
             if (state.userDateModel!.status!)
             {
               LoginInShopApp(context ,message: state.userDateModel!.message ,token: state.userDateModel!.data!.token);
             }
             else
             {
               FlutterToAstItem(txt: state.userDateModel!.message!,state: ToastStates.ERROR);
             }
           }
        } ,
        builder: (context, state){
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: FormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LOGIN",style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 30),),
                          SizedBox(height: 10,),
                          Text("login now to browse our hot offers",style: Theme.of(context).textTheme.bodyText2,),
                          SizedBox(height: 20,),
                          TextFormWidget(context: context,txt:"email",preficon: Icons.email ,Control:emailController,),
                          SizedBox(height: 20,),
                          TextFormWidget(context: context,txt:"password",preficon:Icons.lock ,Control:passwordController,
                            type: TextInputType.visiblePassword,
                            ispass: hidePassword ,
                            sufficon: PasswordIcon ,
                            onTap: (){
                              setState(() {
                                hidePassword = !hidePassword;
                                (hidePassword)?(PasswordIcon = Icons.visibility_off ):(PasswordIcon = Icons.remove_red_eye_outlined);
                              });
                            },
                          ),
                          SizedBox(height: 20,),
                          ConditionalBuilder(
                            condition: state is! LoadLoginState,
                            builder:(context) => MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              onPressed: (){
                                if (FormKey.currentState!.validate())
                                {
                                  LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                }
                              },
                              child: Text("Login",style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),),
                              color:Theme.of(context).accentColor ,
                            ),
                            fallback:  (context)=> Center(child: CircularProgressIndicator(color: Colors.grey,)) ,

                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have any account?"),
                              TextButton(onPressed: (){
                                NavigateToRegister(context);
                              }
                                  , child: Text("REGISTER",style: TextStyle(
                                      color: Theme.of(context).accentColor
                                  ),))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),

      );

  }
}
