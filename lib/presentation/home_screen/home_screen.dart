import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/data/models/home_model.dart';
import 'package:shopping_app/shared/constants/spaces.dart';
import '../../business_logic/cubit/home/home_cubit.dart';
import '../../business_logic/cubit/home/home_states.dart';
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
      listener: (context, state) {},
      builder: (context, state) {
        final homeModel = HomeCubit.get(context).homeModel;
        return ConditionalProgressIndicator(
          condition: homeModel !=null,
          widgetIfTrue: homeModel != null
            ? homeBuilder(homeModel)
            : const Center(child: Text('No data available')),
        );
      },
    );
  }
}

Widget homeBuilder(HomeModel model) => Container(
  width: double.infinity,
  height: double.infinity,
  child: Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 15.w
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spaces.vSpacingM,
          BannersWidget(homeModel: model),
          ProductsWidget(homeModel: model),
        ],
      ),
    ),
  ),
);