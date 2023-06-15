import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/sized_box_widget_profile.dart';
import 'package:sports_store/Core/widget/text_widget.dart';
import 'package:sports_store/Features/ProfileScreen/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey300,
      appBar: AppBar(
        backgroundColor: AppColors.blueAccent,
        elevation: AppSizes.r0,
        centerTitle: true,
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
        title: TextWidget(
          text: 'Profile',
          fontSize: FontSizes.sp18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
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
      body: Consumer<ProfileProvider>(builder: (context, profile, _) {
        return StreamBuilder<QuerySnapshot>(
            stream: profile.usersCollection,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.all(AppSizes.r16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: AppSizes.r50,
                              backgroundColor: AppColors.grey,
                              child: Icon(
                                Icons.person,
                                color: AppColors.black,
                                size: AppSizes.r28,
                              ),
                            ),
                            SizedBox(
                              height: AppSizes.r16,
                            ),
                            TextWidget(
                              text: data['username'],
                              fontSize: FontSizes.sp16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              height: AppSizes.r8,
                            ),
                            TextWidget(
                              text: data['email'],
                              fontSize: FontSizes.sp16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.r28,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppSizes.r10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppSizes.r16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.house,
                                      color: AppColors.blue,
                                      size: AppSizes.r28,
                                    ),
                                    TextWidget(
                                      text: 'Home Address',
                                      fontSize: FontSizes.sp16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                const Divider(),
                                SizedBoxWidgetProfile(
                                  text: data['country'],
                                  icon: Icons.location_on,
                                ),
                                const Divider(),
                                SizedBoxWidgetProfile(
                                  text: data['city'],
                                  icon: Icons.location_on,
                                ),
                                const Divider(),
                                SizedBoxWidgetProfile(
                                  text: data['streetandregion'],
                                  icon: Icons.location_on,
                                ),
                                const Divider(),
                                SizedBoxWidgetProfile(
                                  text: data['mobilenumber'],
                                  icon: Icons.location_on,
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            });
      }),
    );
  }
}
