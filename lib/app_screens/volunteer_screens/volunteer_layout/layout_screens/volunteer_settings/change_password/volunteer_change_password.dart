
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'cubit/volunteer_change_password_cubit.dart';
import 'cubit/volunteer_change_password_states.dart';
class VolunteerChangePassword extends StatelessWidget {
  var passwordController = TextEditingController();
  var newpasswordController = TextEditingController();
  var confnewpasswordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
  create: (context) => VolunteerChangePasswordCubit(),
  child: BlocConsumer<VolunteerChangePasswordCubit, VolunteerChangePasswordStates>(
  listener: (context, state) {
    var cubit = VolunteerChangePasswordCubit.get(context);
    int? status = cubit.status;

    if (status==200){
      showToast('Password changed successfully'.tr(),
        context: context,
        animation: StyledToastAnimation.scale,
        duration: Duration(seconds: 5),
        backgroundColor: Color(0xff6bc17a),
        borderRadius: BorderRadius.circular(50),
        alignment: Alignment.bottomCenter,
      );
      Navigator.pop(context);

    }

  },
  builder: (context, state) {
    var cubit = VolunteerChangePasswordCubit.get(context);
    return Scaffold(
    body: Stack(
    children: [
      Container(
        width: double.infinity,
        height: height ,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/background2.jpg',
            ),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: EdgeInsetsDirectional.only(bottom:height*0.755),
          child: const Text(
              'Change Password',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1,1),
                  ),
                ],
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
          ).tr(),
        ),
      ),
      Padding(
        padding:  EdgeInsetsDirectional.only(bottom: height*0.25),
        child: Center(
          child: SizedBox(
            width: width * 0.766,
            child: defaultFormField(
              label: 'Current Password'.tr(),
              controller:passwordController,
              type: TextInputType.visiblePassword,
              ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsetsDirectional.only(bottom:height*0.076),
        child: Center(
          child: SizedBox(
            width: width * 0.766,
            child: defaultFormField(
              label: 'New Password'.tr(),
             controller:newpasswordController,
              type: TextInputType.visiblePassword,
            ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsetsDirectional.only(top:height*0.113),
        child: Center(
          child: Form(
            key: FormKey,
            child: SizedBox(
              width: width * 0.766,
              child: defaultFormField(
                label: 'Confirm New Password'.tr(),
                controller:confnewpasswordController,
                type: TextInputType.visiblePassword,
                validate:  (value) {
                  if (value!=newpasswordController.text) {
                    return ' Passwords are not Match  '.tr();
                  }
                },
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsetsDirectional.only(top:height*0.45, end: width*0.39),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadiusDirectional.circular(27),
            ),
            child: defaultButton(
              backgroundColor: Colors.white,
              width: width * 0.35,
              text: 'Cancel'.tr(),
              function: (){
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      ConditionalBuilder(
        condition: state is! VolunteerChangeLoadingState ,
        builder: (context)=>Padding(
          padding:  EdgeInsetsDirectional.only(top:height*0.45, start: width*0.419),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadiusDirectional.circular(27),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/button.jpg'),
                      fit: BoxFit.cover)
              ),
              child: defaultButton(
                function: () {
                  if (FormKey.currentState!.validate()) {
                    cubit.VolunteerChangePassword(
                      new_password: newpasswordController.text,
                      new_password_confirmation: confnewpasswordController.text,
                      password: passwordController.text,
                    );
                  }
                },
                width: width * 0.35,
                text: 'Save'.tr(),

              ),
            ),
          ),
        ),
        fallback: (context)=>const Center(child: CircularProgressIndicator()),
      ),
     ],
     ),
    );
  },
),
);
  }
}
