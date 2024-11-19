import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/search/search_cubit.dart';
import 'package:shopping_app/business_logic/cubit/search/search_states.dart';
import 'package:shopping_app/data/models/search_model.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if(state is SearchSuccessState) {
          searchModel = SearchCubit.get(context).searchModel;
        }
      },
      builder: (context, state) {
        if (state is SearchLoadingState){
          return  const Center(child: CircularProgressIndicator());
        }
        else if (searchModel != null) {
          if(searchModel?.data?.data?.isEmpty ?? true) {
            return const Center(child: Text('No Results Found'));
          }
          else {
            return resultBuilder(searchModel!);
          }
        }
        else {
          return Container();
        }
      },
    );
  }
}

Widget resultBuilder(SearchModel model) => Padding(
  padding: EdgeInsets.symmetric(
    horizontal: 15.w
  ),
  child: ListView.separated(
    itemCount: model.data!.data!.length,
    itemBuilder: (context, index) => resultItem(model.data!.data![index]),
    separatorBuilder: (context, index) => SizedBox(height: 10.h),
  ),
);

Widget resultItem(Product model) => Container(
  height: 90.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.r),
    color: AppColors.primaryColor2,
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: 100.w,
          height: 85.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
              image: NetworkImage(
                model.image!,
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
                model.name!,
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
                    'LE ${model.price.round()}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Spaces.hSpacingM,
                  Text(
                    model.oldPrice != null
                        ? 'LE ${model.oldPrice.round()}'
                        : '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              )
            ],
          ),
        ),
      ],
    ),
  ),
);