import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gst_calcuator/common/common_widget.dart';
import 'package:gst_calcuator/di/get_it.dart';
import 'package:gst_calcuator/features/tax_slab/presentation/cubit/tax_slab_cubit.dart';

class TaxSlabScreen extends StatefulWidget {
  const TaxSlabScreen({super.key});

  @override
  State<TaxSlabScreen> createState() => _TaxSlabScreenState();
}

class _TaxSlabScreenState extends State<TaxSlabScreen> {
  late TaxSlabCubit taxSlabCubit;

  @override
  void initState() {
    taxSlabCubit = getItInstance<TaxSlabCubit>();
    taxSlabCubit.loadData();
    super.initState();
  }

  @override
  void dispose() {
    taxSlabCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 30,
              alignment: Alignment.center,
              child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/back_arrow.svg', height: 30, width: 30),
            ),
          ),
          title: CommonWidget.commonText(text: 'Change Tax Slab'),
          surfaceTintColor: AppColor.whiteBackGroundColor,
          backgroundColor: AppColor.whiteBackGroundColor,
          actions: [
            InkWell(
              onTap: () => taxSlabCubit.updateGstData(context: context),
              child: Container(
                height: 25,
                alignment: Alignment.center,
                child: CommonWidget.imageBuilder(imageUrl: 'assets/images/svg/true.svg', height: 25, width: 25),
              ),
            ),
            SizedBox(width: 15.w),
          ],
          bottom: const PreferredSize(preferredSize: Size(50, 15), child: Divider()),
        ),
        backgroundColor: AppColor.whiteBackGroundColor,
        body: BlocBuilder<TaxSlabCubit, TaxSlabState>(
          bloc: taxSlabCubit,
          builder: (context, state) {
            if (state is TaxSlabLoadedState) {
              return Column(
                children: [
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff606060).withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            state.gstPlusSlabList.length,
                            (index) => Container(
                              height: 70.h,
                              width: 65.w,
                              padding: EdgeInsets.only(left: 18.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.primary1Color),
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffE0E9F1),
                              ),
                              alignment: Alignment.center,
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: TextEditingController(text: state.gstPlusSlabList[index]),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) => taxSlabCubit.changePlusData(
                                  state: state,
                                  value: value,
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            state.gstMinusSlabList.length,
                            (index) => Container(
                              height: 70.h,
                              width: 65.w,
                              padding: EdgeInsets.only(left: 18.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.primary1Color),
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffE0E9F1),
                              ),
                              alignment: Alignment.center,
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: TextEditingController(text: state.gstMinusSlabList[index]),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) => taxSlabCubit.changeMinusData(
                                  state: state,
                                  value: value,
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
