import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/home_model.dart';
import 'package:shopping_app/presentation/home_screen/home_screen_widgets/categories_widget.dart';
import '../../business_logic/cubit/home/home_cubit.dart';
import '../../business_logic/cubit/home/home_states.dart';
import '../../data/models/categories_model.dart';
import 'home_screen_widgets/banners_widget.dart';
import 'home_screen_widgets/products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSuccessState) {
          homeModel = HomeCubit.get(context).homeModel;
        }
        else if (state is HomeSuccessGetCategoriesState) {
          categoriesModel = HomeCubit.get(context).categoriesModel;
        }
      },
      builder: (context, state) {
        // ToDo : #
        homeModel = HomeCubit.get(context).homeModel;
        categoriesModel = HomeCubit.get(context).categoriesModel;
        if (homeModel != null && categoriesModel != null) {
          return homeBuilder(homeModel!, categoriesModel!);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget homeBuilder(HomeModel homeModel, CategoriesModel categoriesModel) => SizedBox(
  width: double.infinity,
  height: double.infinity,
  child: SingleChildScrollView(
    child: Column(
      children: [
        BannersWidget(homeModel: homeModel),
        CategoriesWidget(categoriesModel: categoriesModel),
        ProductsWidget(homeModel: homeModel),
      ],
    ),
  ),
);