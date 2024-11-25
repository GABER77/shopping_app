import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/favorite/favorite_cubit.dart';
import 'package:shopping_app/business_logic/cubit/favorite/favorite_states.dart';
import 'package:shopping_app/data/models/favorites_model.dart';
import 'package:shopping_app/shared/widgets/favorite_button_widget.dart';
import 'package:shopping_app/shared/widgets/product_item_widget.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  FavoritesModel? favoritesModel;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ));

    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavoritesData(),
      child: BlocConsumer<FavoriteCubit, FavoriteStates>(
        listener: (context, state) {
          if (state is FavoriteSuccessState) {
            favoritesModel = FavoriteCubit.get(context).favoritesModel!;
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (favoritesModel != null) {
            if (favoritesModel?.data?.data?.isEmpty ?? true) {
              return const Center(child: Text('No Favorites'));
            } else {
              return favoritesBuilder(favoritesModel!, context);
            }
          } else {
            return const Center(child: Text('No Data'));
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

Widget buildFavoriteItem(FavoriteData model, context, List<FavoriteData> favoritesList, int index) => ProductItemWidget(
  image: model.product!.image!,
  name: model.product!.name!,
  price: model.product!.price,
  oldPrice: model.product!.oldPrice,
  model: model.product!,
  extraButton: FavoriteButton(
    id: model.product!.id!,
    cubit: WhichCubit.FAVORITE,
    extraAction: () {
      favoritesList.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Item removed from favorites')
        ),
      );
    },
  ),
);