import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/search/search_cubit.dart';
import 'package:shopping_app/business_logic/cubit/search/search_states.dart';
import 'package:shopping_app/data/models/search_model.dart';
import 'package:shopping_app/shared/widgets/product_item_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if (state is SearchSuccessState) {
          searchModel = SearchCubit.get(context).searchModel;
        }
      },
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (searchModel != null) {
          if (searchModel?.data?.data?.isEmpty ?? true) {
            return const Center(child: Text('No Results Found'));
          } else {
            return resultBuilder(searchModel!);
          }
        } else {
          return Container();
        }
      },
    );
  }
}

Widget resultBuilder(SearchModel model) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: ListView.separated(
        itemCount: model.data!.data!.length,
        itemBuilder: (context, index) =>
            buildResultItem(model.data!.data![index]),
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
      ),
    );

Widget buildResultItem(Product model) => ProductItemWidget(
  image: model.image!,
  name: model.name!,
  price: model.price,
  oldPrice: model.oldPrice,
  model: model,
);