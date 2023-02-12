import 'package:eshop/views/pages/add_product/add_product.dart';
import 'package:eshop/views/pages/product_screen/favourite_screen.dart';
import 'package:eshop/views/pages/product_screen/widgets/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'controller/home_controller.dart';
import 'controller/product_controller.dart';
import 'views/pages/general_connection_page.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              initialRoute: "/",
              routes: {
                "/": (_) => const GeneralPage(),
                "/search": (BuildContext context) => const SearchFilter(),
                "/fav": (BuildContext context) => const FavouriteScreen(),
                "/add": (BuildContext context) => const AddProductPage(),
              },
              debugShowCheckedModeBanner: false,

            );
          }),
    );
  }
}