import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../controller/product_controller.dart';
import '../../../utils/style.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = context.read<ProductController>();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  event.getImageCamera();
                  Navigator.pop(context);
                },
                child: Container(
                    height: 65.r,
                    width: 65.r,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBrandColor.withOpacity(0.75)),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 28,
                      color: kWhiteColor,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  event.getImageGallery();
                  Navigator.pop(context);
                },
                child: Container(
                    height: 65.r,
                    width: 65.r,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBrandColor.withOpacity(0.75)),
                    child: const Icon(
                      Icons.folder_copy,
                      size: 28,
                      color: kWhiteColor,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  event.clearImage();
                  Navigator.pop(context);
                },
                child: Container(
                    height: 65.r,
                    width: 65.r,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBrandColor.withOpacity(0.75)),
                    child: const Icon(
                      Icons.delete,
                      size: 28,
                      color: kWhiteColor,
                    )),
              ),
            ],
          ),
          32.verticalSpace,
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kBrandColor.withOpacity(0.75),
              ),
              child: Text(
                "Cencel",
                style: Style.textStyleSemiBold(textColor: kWhiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
