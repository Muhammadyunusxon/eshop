import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../controller/home_controller.dart';
import '../../../utils/components/my_form_field.dart';
import '../../../utils/constants.dart';
import '../../../utils/style.dart';

class PriceRange extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;

  const PriceRange(
      {Key? key, required this.fromController, required this.toController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        12.h.verticalSpace,
        Text("Price range", style: Style.textStyleSemiBold(size: 18)),
        18.h.verticalSpace,
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text("From",
                          style: Style.textStyleSemiBold(size: 15))),
                  12.h.verticalSpace,
                  MyFormFiled(
                    formatter: true,
                    prefix: Text("\$",style: Style.textStyleSemiBold(),),
                    onValueChange: (s) {
                      if (s < state.currentRangeValues.end && s > 0) {
                        event.changeCurrent(RangeValues(
                            s.toDouble(), state.currentRangeValues.end));
                      }
                    },
                    textInputType: TextInputType.number,
                    controller: fromController,
                    title: "From",
                    titleColor: kTextDarkColor.withOpacity(0.6),
                    fillColor: kWhiteColor,
                    borderColor: Style.borderColor.withOpacity(0.2),
                  )
                ],
              ),
            ),
            16.w.horizontalSpace,
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child:
                          Text("To", style: Style.textStyleSemiBold(size: 15))),
                  12.h.verticalSpace,
                  MyFormFiled(
                    prefix: Text("\$",style: Style.textStyleSemiBold(),),
                    formatter: true,
                    onValueChange: (s) {
                      if (s > state.currentRangeValues.start && s < 5000) {
                        event.changeCurrent(RangeValues(
                          state.currentRangeValues.start,
                          s.toDouble(),
                        ));
                      }
                    },
                    textInputType: TextInputType.number,
                    controller: toController,
                    title: "To",
                    titleColor: kTextDarkColor.withOpacity(0.6),
                    fillColor: kWhiteColor,
                    borderColor: Style.borderColor.withOpacity(0.2),
                  ),
                ],
              ),
            ),
          ],
        ),
        RangeSlider(
          inactiveColor: kBrandColor.withOpacity(0.2),
          activeColor: kBrandColor,
          values: state.currentRangeValues,
          max: 5000,
          divisions: 1000,
          labels: RangeLabels(
            state.currentRangeValues.start.round().toString(),
            state.currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            fromController.text =
                state.currentRangeValues.start.round().toString();
            toController.text = state.currentRangeValues.end.round().toString();
            event.changeCurrent(values);
          },
        ),
        12.h.verticalSpace,
      ],
    );
  }
}
