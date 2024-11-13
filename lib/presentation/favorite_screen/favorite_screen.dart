import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/data/models/favorites_model.dart';
import '../../business_logic/cubit/home/home_cubit.dart';
import '../../business_logic/cubit/home/home_states.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';
import 'is_favorite_widgets.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  FavoritesModel? favoritesModel;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeCubit.get(context).getFavoritesData();
    });

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSuccessGetFavoritesState) {
          favoritesModel = HomeCubit.get(context).favoritesModel!;
        }
      },
      builder: (context, state) {
        if (favoritesModel != null) {
          if (favoritesModel?.data?.data?.isEmpty ?? true) {
            return const Center(child: Text('No Favorites'));
          } else {
            return favoritesBuilder(favoritesModel!, context);
          }
        }
        else if (state is! HomeSuccessGetFavoritesState){
          return const Center(child: CircularProgressIndicator());
        }
        else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }
}

Widget favoritesBuilder(FavoritesModel model, context) => Padding(
  padding: EdgeInsets.all(15.r),
  child: ListView.separated(
    itemCount: model.data!.data!.length,
    itemBuilder: (context, index) => buildFavoriteItem(model.data!.data![index], context),
    separatorBuilder: (context, index) => SizedBox(height: 10.h),
  ),
);

Widget buildFavoriteItem(FavoriteData model, context) => Container(
  height: 100.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.r),
    color: AppColors.primaryColor2,
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: 110.w,
          height: 100.h,
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
                  color: AppColors.secondaryColor,
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
                  IconButton(
                    onPressed:() {
                      HomeCubit.get(context).changeFavorites(model.product!.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: AppColors.primaryColor1,
                      child: (model.product != null && HomeCubit.get(context).favorites[model.product!.id] != null)
                          ? (HomeCubit.get(context).favorites[model.product!.id]!
                          ? inFavorites()
                          : notInFavorites())
                          : notInFavorites(),
                    ),

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