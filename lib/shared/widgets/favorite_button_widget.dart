import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business_logic/cubit/favorite/favorite_cubit.dart';
import '../../data/repository/favorite_repositery.dart';
import '../../business_logic/cubit/home/home_cubit.dart';
import '../constants/colors.dart';

class FavoriteButton extends StatelessWidget {
  FavoriteButton({
    super.key,
    required this.id,
    required this.cubit,
    this.extraAction,
    this.buttonColor,
  });

  final FavoritesRepository favoritesRepository = FavoritesRepository.instance;
  final int id;
  final WhichCubit cubit;
  final VoidCallback? extraAction;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:() {
        if (cubit == WhichCubit.HOME) {
          HomeCubit.get(context).changeFavorites(id);
          if (extraAction != null) extraAction!();
        } else if (cubit == WhichCubit.FAVORITE) {
          FavoriteCubit.get(context).changeFavorites(id);
          if (extraAction != null) extraAction!();
        }
      },
      icon: CircleAvatar(
          backgroundColor: buttonColor ?? AppColors.primaryColor1,
          child: favoritesRepository.favorites[id]!
              ? inFavorites()
              : notInFavorites()
      ),
    );
  }
}

enum WhichCubit {HOME, FAVORITE}

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