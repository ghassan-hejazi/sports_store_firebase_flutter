import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/widget/text_form_field_widget.dart';
import 'package:sports_store/Features/AuthLogin/SignInScreen/signin_provider.dart';
import 'package:sports_store/Features/AuthLogin/SignUpScreen/signup_screen.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/elevated_button_widget.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(builder: (context, signIn, _) {
      return WillPopScope(
        onWillPop: () => signIn.willPopScope(context),
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
              text: 'Login',
              fontSize: FontSizes.sp24,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
          body: Form(
            key: signIn.formKey1,
            child: ListView(
              padding: EdgeInsets.all(AppSizes.r16),
              children: [
                SizedBox(height: AppSizes.r50),
                TextFormFieldWidget(
                  controller: signIn.email,
                  labelText: 'E-Mail',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  obscureText: false,
                  validatorString: 'Please enter E-Mail',
                  maxLines: 1,
                ),
                SizedBox(height: AppSizes.r20),
                TextFormFieldWidget(
                  controller: signIn.password,
                  labelText: 'Password',
                  keyboardType: TextInputType.name,
                  icon: Icons.lock,
                  obscureText: signIn.passwordVisible,
                  validatorString: 'Please enter  Password',
                  maxLines: 1,
                  suffixIcon: IconButton(
                    icon: signIn.passwordVisible
                        ? Icon(
                            Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: AppColors.red,
                          ),
                    onPressed: () {
                      signIn.getPasswordVisible();
                    },
                  ),
                ),
                SizedBox(height: AppSizes.r4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: TextWidget(
                        text: 'Forgot Password ?',
                        fontSize: FontSizes.sp14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.r16),
                ElevatedButtonWidget(
                  text: 'Login',
                  onPressed: () async {
                    await signIn.signIn(context);
                  },
                ),
                SizedBox(height: AppSizes.r16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'dont have an account ?',
                      fontSize: FontSizes.sp14,
                      fontWeight: FontWeight.w600,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                            (route) => false);
                      },
                      child: TextWidget(
                        text: 'Create account',
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
