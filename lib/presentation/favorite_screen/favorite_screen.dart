import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/data/models/favorites_model.dart';
import '../../business_logic/cubit/home/home_cubit.dart';
import '../../business_logic/cubit/home/home_states.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';
import '../../shared/widgets/progress_indicator.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final favoritesModel = HomeCubit.get(context).favoritesModel;
        return ConditionalProgressIndicator(
          condition: favoritesModel !=null,
          widgetIfTrue: favoritesModel != null
              ? favoritesBuilder(favoritesModel, context)
              : const Center(child: Text('No data available')),
        );
      },
    );
  }
}

Widget favoritesBuilder(FavoritesModel model, context) => Padding(
  padding: EdgeInsets.all(15.r),
  child: ListView.separated(
    itemCount: model.data!.data!.length,
    itemBuilder: (context, index) => buildFavoriteItem(model.data!.data![index], context),
    separatorBuilder: (context, index) => SizedBox(height: 20.h),
  ),
);

Widget buildFavoriteItem(FavoriteData model, context) => Container(
  height: 110.h,
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
          height: 110.h,
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
          width: 15.w,
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
                  fontSize: 15.sp,
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
                      fontSize: 14.sp,
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
                      fontSize: 13.sp,
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
                      child: HomeCubit.get(context).favorites[model.product!.id]!
                          ? inFavorites()
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

Widget inFavorites() => Icon(
  Icons.favorite,
  size: 17.sp,
  color: Colors.red,
);

Widget notInFavorites() => Icon(
  Icons.favorite_border,
  size: 17.sp,
  color: AppColors.secondaryColor,
);