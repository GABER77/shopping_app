import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/favorite/favorite_cubit.dart';
import 'package:shopping_app/business_logic/cubit/favorite/favorite_states.dart';
import 'package:shopping_app/data/models/favorites_model.dart';
import 'package:shopping_app/shared/widgets/favorite_button_widget.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  FavoritesModel? favoritesModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavoritesData(),
      child: BlocConsumer<FavoriteCubit, FavoriteStates>(
        listener: (context, state) {
          if (state is FavoriteSuccessState) {
            favoritesModel = FavoriteCubit.get(context).favoritesModel!;
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          else if (favoritesModel != null) {
            if (favoritesModel?.data?.data?.isEmpty ?? true) {
              return const Center(child: Text('No Favorites'));
            }
            else {
              return favoritesBuilder(favoritesModel!, context);
            }
          }
          else {
            return  const Center(child: Text('No Data'));
          }
        },
      ),
    );
  }
}

Widget favoritesBuilder(FavoritesModel model, context) => Padding(
  padding: EdgeInsets.only(
    left: 15.w,
    right: 15.w,
    top: 15.h,
  ),
  child: ListView.separated(
    itemCount: model.data!.data!.length,
    itemBuilder: (context, index) => buildFavoriteItem(model.data!.data![index], context, model.data!.data!, index),
    separatorBuilder: (context, index) => SizedBox(height: 10.h),
  ),
);

Widget buildFavoriteItem(FavoriteData model, context, List<FavoriteData> favoritesList, int index) => Container(
  height: 100.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.r),
    color: AppColors.primaryColor2,
  ),
  child: Padding(
    padding:  const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: 105.w,
          height: 85.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
              image: NetworkImage(
                model.product!.image!,
              ),
            ),
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'LE ${model.product!.price.round()}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Spaces.hSpacingM,
                  Text(
                    model.product!.oldPrice != null
                        ? 'LE ${model.product!.oldPrice.round()}'
                        : '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  FavoriteButton(
                    id: model.product!.id!,
                    cubit: WhichCubit.FAVORITE,
                    extraAction: () {
                      favoritesList.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item removed from favorites')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);