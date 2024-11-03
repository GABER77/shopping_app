import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/data/models/home_model.dart';

class BannersWidget extends StatelessWidget {
  const BannersWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: CarouselSlider(
        items: homeModel.data?.banners.map((e) => ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            height: 180.h,
            fit: BoxFit.cover,
          ),
        )).toList(),
        options: CarouselOptions(
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}