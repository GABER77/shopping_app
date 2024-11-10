import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/home_model.dart';
import 'package:shopping_app/presentation/home_screen/home_screen_widgets/categories_widget.dart';
import 'package:shopping_app/shared/core/toast.dart';
import '../../business_logic/cubit/home/home_cubit.dart';
import '../../business_logic/cubit/home/home_states.dart';
import '../../data/models/categories_model.dart';
import '../../shared/widgets/progress_indicator.dart';
import 'home_screen_widgets/banners_widget.dart';
import 'home_screen_widgets/products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeSuccessChangeFavoritesState){
          if(!state.model.status!){
            customToast(
              message: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        final homeModel = HomeCubit.get(context).homeModel;
        final categoriesModel = HomeCubit.get(context).categoriesModel;
        return ConditionalProgressIndicator(
          // ToDo: #
          condition: homeModel !=null && categoriesModel != null,
          widgetIfTrue: homeModel != null && categoriesModel != null
            ? homeBuilder(homeModel, categoriesModel)
            : const Center(child: Text('No data available')),
        );
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