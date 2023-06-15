import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/widget/text_form_field_widget.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/elevated_button_widget.dart';
import 'package:sports_store/Core/widget/text_widget.dart';
import 'package:sports_store/Features/AuthLogin/SignInScreen/signin_screen.dart';
import 'package:sports_store/Features/AuthLogin/SignUpScreen/signup_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, signUp, _) {
      return WillPopScope(
        onWillPop: () => signUp.onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.blueAccent,
            elevation: AppSizes.r0,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, AppSizes.r8),
              child: const SizedBox(),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(AppSizes.r150, AppSizes.r16),
                bottomRight: Radius.elliptical(AppSizes.r150, AppSizes.r16),
              ),
            ),
            title: TextWidget(
              text: 'Create Account',
              fontSize: FontSizes.sp24,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                  size: AppSizes.r25,
                )),
          ),
          body: Form(
            key: signUp.formKey2,
            child: ListView(
              padding: EdgeInsets.all(AppSizes.r16),
              children: [
                TextFormFieldWidget(
                  controller: signUp.name,
                  labelText: 'Full Name',
                  keyboardType: TextInputType.name,
                  icon: Icons.person,
                  obscureText: false,
                  validatorString: 'Please enter your full name',
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.r20),
                TextFormFieldWidget(
                  controller: signUp.email,
                  labelText: 'E-Mail',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  obscureText: false,
                  validatorString: 'Please enter your full name',
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.r20),
                TextFormFieldWidget(
                  controller: signUp.password,
                  labelText: 'Password',
                  keyboardType: TextInputType.name,
                  icon: Icons.lock,
                  obscureText: signUp.passwordVisible,
                  validatorString: 'Please enter a mobile phone number',
                  maxLines: 1,
                  suffixIcon: IconButton(
                    icon: signUp.passwordVisible
                        ? Icon(
                            Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: AppColors.red,
                          ),
                    onPressed: () {
                      signUp.getPasswordVisible();
                    },
                  ),
                ),
                SizedBox(height: AppSizes.r16),
                TextFormFieldWidget(
                  controller: signUp.mobilenumber,
                  labelText: 'Mobile Number',
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone,
                  obscureText: false,
                  validatorString: 'Please enter a mobile phone number',
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.r20),
                TextFormFieldWidget(
                  controller: signUp.country,
                  labelText: 'Country',
                  keyboardType: TextInputType.name,
                  icon: Icons.location_on,
                  obscureText: false,
                  validatorString: 'Please enter the country',
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.r20),
                TextFormFieldWidget(
                  controller: signUp.city,
                  labelText: 'City',
                  keyboardType: TextInputType.name,
                  icon: Icons.location_on,
                  obscureText: false,
                  validatorString: 'Please enter the city',
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.r20),
                TextFormFieldWidget(
                  controller: signUp.streetAndRegion,
                  labelText: 'Street Or Region',
                  keyboardType: TextInputType.name,
                  icon: Icons.location_on,
                  obscureText: false,
                  validatorString: 'Please enter the street and district',
                  maxLines: 3,
                ),
                SizedBox(height: AppSizes.r20),
                ElevatedButtonWidget(
                  text: 'Create',
                  onPressed: () async {
                    await signUp.addDataUser(context);
                  },
                ),
                SizedBox(height: AppSizes.r16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'do you have an account ?',
                      fontSize: FontSizes.sp14,
                      fontWeight: FontWeight.w600,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                            (route) => false);
                      },
                      child: TextWidget(
                        text: 'Sing in',
                        fontSize: FontSizes.sp14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
