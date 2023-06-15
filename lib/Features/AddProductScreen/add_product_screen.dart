// ignore_for_file: must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sports_store/Core/widget/text_form_field_widget.dart';
import 'package:sports_store/Features/AddProductScreen/add_product_provider.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/elevated_button_widget.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
          text: 'Add Product',
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
      body: Consumer<AddProductProvider>(
        builder: (context, product, _) {
          return ListView(
            padding: EdgeInsets.all(AppSizes.r16),
            children: [
              product.imageurl == null
                  ? Container(
                      height: AppSizes.r250,
                      decoration: BoxDecoration(
                        color: AppColors.black12,
                        borderRadius: BorderRadius.circular(AppSizes.r16),
                      ),
                      child: Icon(
                        Icons.collections,
                        color: AppColors.black45,
                        size: AppSizes.r75,
                      ),
                    )
                  : Container(
                      width: AppSizes.r250,
                      height: AppSizes.r250,
                      decoration: BoxDecoration(
                        color: AppColors.black12,
                        borderRadius: BorderRadius.circular(AppSizes.r16),
                      ),
                      child: CarouselSlider.builder(
                          itemCount: product.downloadURLs.length,
                          options: CarouselOptions(
                              height: AppSizes.r250,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              onPageChanged: (index, reason) {
                                product.activeInde(index);
                              }),
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
                            return Image.network(
                              product.downloadURLs[index],
                            );
                          }),
                    ),
              SizedBox(height: AppSizes.r16),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: product.activeIndex,
                  count: product.downloadURLs.length,
                  effect: WormEffect(
                    dotWidth: AppSizes.r16,
                    dotHeight: AppSizes.r10,
                    spacing: AppSizes.r4,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.r16),
              ElevatedButtonWidget(
                onPressed: () {
                  product.addImage(context);
                },
                text: 'Add Images',
              ),
              const SizedBox(height: 32),
              TextFormFieldWidget(
                controller: product.title,
                labelText: 'Title',
                keyboardType: TextInputType.name,
                icon: Icons.title,
                obscureText: false,
                validatorString: 'Please Enter Title',
                maxLines: 3,
              ),
              SizedBox(height: AppSizes.r28),
              TextFormFieldWidget(
                controller: product.price,
                labelText: 'Price',
                keyboardType: TextInputType.number,
                icon: Icons.attach_money,
                obscureText: false,
                validatorString: 'Please Enter Price',
                maxLines: 1,
              ),
              SizedBox(height: AppSizes.r28),
              TextFormFieldWidget(
                controller: product.brand,
                labelText: 'Brand',
                keyboardType: TextInputType.name,
                icon: Icons.local_offer,
                obscureText: false,
                validatorString: 'Please Enter Brand',
                maxLines: 1,
              ),
              SizedBox(height: AppSizes.r28),
              TextFormFieldWidget(
                controller: product.description,
                labelText: 'Description',
                keyboardType: TextInputType.name,
                icon: Icons.description,
                obscureText: false,
                validatorString: 'Please Enter Description',
                maxLines: 3,
              ),
              SizedBox(height: AppSizes.r28),
              DropdownSearch<String>.multiSelection(
                items: const ['S', 'M', 'L', 'XL', 'XXL', 'XXXL', '4XL', '5XL'],
                onChanged: (value) {
                  product.items = value;
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: FontSizes.sp18,
                      decorationThickness: AppSizes.r0,
                    ),
                    labelText: 'Size',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppSizes.r16,
                      horizontal: AppSizes.r0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r40),
                      borderSide: BorderSide(color: AppColors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r40),
                      borderSide: BorderSide(color: AppColors.blue),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r40),
                      borderSide: BorderSide(color: AppColors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r40),
                      borderSide: BorderSide(color: AppColors.blue),
                    ),
                    prefixIcon: Icon(
                      Icons.text_increase,
                      size: AppSizes.r25,
                      color: AppColors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.r28),
              ElevatedButtonWidget(
                text: 'Add Product',
                onPressed: () async {
                  product.writeData(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
