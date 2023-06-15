// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/elevated_button_widget.dart';
import 'package:sports_store/Core/widget/text_form_field_widget.dart';
import 'package:sports_store/Core/widget/text_widget.dart';
import 'edit_profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  String userId;
  Map<String, dynamic> data;

  EditProfileScreen({
    super.key,
    required this.data,
    required this.userId,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController streetandregion = TextEditingController();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.data['username']);
    mobilenumber = TextEditingController(text: widget.data['mobilenumber']);
    country = TextEditingController(text: widget.data['country']);
    city = TextEditingController(text: widget.data['city']);
    streetandregion =
        TextEditingController(text: widget.data['streetandregion']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueAccent,
        elevation: AppSizes.r0,
        centerTitle: true,
        title: TextWidget(
          text: 'Edit Profile',
          fontSize: FontSizes.sp24,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: AppSizes.r25,
          ),
        ),
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
      ),
      body: Consumer<EditProfileProvider>(builder: (context, editProfile, _) {
        return Form(
          key: formKey3,
          child: ListView(
            padding: EdgeInsets.all(AppSizes.r16),
            children: [
              SizedBox(height: AppSizes.r25),
              TextFormFieldWidget(
                controller: name,
                labelText: 'Full Name',
                keyboardType: TextInputType.name,
                icon: Icons.person,
                obscureText: false,
                validatorString: 'Please enter your full name',
                maxLines: 2,
              ),
              SizedBox(height: AppSizes.r28),
              TextFormFieldWidget(
                controller: mobilenumber,
                labelText: 'Mobile Number',
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
                obscureText: false,
                validatorString: 'Please enter a mobile phone number',
                maxLines: 2,
              ),
              SizedBox(height: AppSizes.r28),
              TextFormFieldWidget(
                controller: country,
                labelText: 'Country',
                keyboardType: TextInputType.name,
                icon: Icons.location_on,
                obscureText: false,
                validatorString: 'Please enter the country',
                maxLines: 1,
              ),
              SizedBox(height: AppSizes.r28),
              TextFormFieldWidget(
                controller: city,
                labelText: 'City',
                keyboardType: TextInputType.name,
                icon: Icons.location_on,
                obscureText: false,
                validatorString: 'Please enter the city',
                maxLines: 1,
              ),
              SizedBox(height: AppSizes.r28),
              TextFormFieldWidget(
                controller: streetandregion,
                labelText: 'Street Or Region',
                keyboardType: TextInputType.name,
                icon: Icons.location_on,
                obscureText: false,
                validatorString: 'Please enter the street and district',
                maxLines: 3,
              ),
              SizedBox(height: AppSizes.r64),
              ElevatedButtonWidget(
                text: 'Save Edit',
                onPressed: () async {
                  await editProfile.editProfileData(
                    context,
                    widget.userId,
                    name.text,
                    mobilenumber.text,
                    country.text,
                    city.text,
                    streetandregion.text,
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
