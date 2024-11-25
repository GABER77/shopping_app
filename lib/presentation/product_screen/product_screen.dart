import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/presentation/product_screen/add_to_cart_button.dart';
import 'package:shopping_app/shared/constants/colors.dart';
import 'package:shopping_app/shared/core/navigation.dart';
import 'package:shopping_app/shared/widgets/favorite_button_widget.dart';
import '../../shared/constants/spaces.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(this.productModel, {super.key});
  final dynamic productModel;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Color> colors = [
    Colors.black,
    Colors.blueAccent,
    Colors.grey,
    Colors.white
  ];
  List<String> sections = [
    'Description',
    'delivery',
    'Reviews',
  ];
  int selectedColor = 0;
  int selectedSection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AddToCartButton(productID: widget.productModel!.id!),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
            ),
            expandedHeight: 200.h,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                navigateFrom(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryColor1,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: AppColors.primaryColor1,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Center(
                      child: SizedBox(
                        width: 250.w,
                        height: 250.h,
                        child: Image.network(
                          widget.productModel!.image!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor1,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35.r),
                  topLeft: Radius.circular(35.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  right: 15.w,
                  left: 15.w,
                  top: 20.h,
                ),
                child: productDetails(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productDetails() => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.productModel!.name!,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Text(
              'LE ${widget.productModel!.price!.round()}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            Spaces.hSpacingL,
            Text(
              widget.productModel!.oldPrice != null ? 'LE ${widget.productModel!.oldPrice.round()}' : '',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const Spacer(),
            FavoriteButton(
              id: widget.productModel!.id!,
              cubit: WhichCubit.HOME,
              buttonColor: AppColors.primaryColor2,
              extraAction: () {
                setState(() {});
              },
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Colors',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: List.generate(
            4,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedColor == index
                      ? AppColors.primaryColor1
                      : colors[index],
                  border: selectedColor == index
                      ? Border.all(
                          color: colors[index],
                        )
                      : null,
                ),
                padding: selectedColor == index ? const EdgeInsets.all(4) : null,
                margin: EdgeInsets.only(right: 13.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 22.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            sections.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedSection = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 100.w,
                height: 35.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: selectedSection== index
                        ? AppColors.secondaryColor
                        : null
                ),
                child: Center(
                  child: Text(
                    sections[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: selectedSection == index
                            ? AppColors.primaryColor1
                            : AppColors.secondaryColor
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          widget.productModel!.description!,
          maxLines: 50,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 200.h,
        ),
      ],
    ),
  );
}