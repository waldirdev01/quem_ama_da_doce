import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/custom_drawer/custom_drawer.dart';
import '../../models/app_user/app_user_manager.dart';
import '../../models/page_manager.dart';
import '../admin_screens/admins_screen.dart';
import '../home/home_screen.dart';
import '../products/products_screen.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => PageManager(pageController: pageController),
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                const HomeScreen(),
                ProductsScreen(),
                Scaffold(
                  drawer: const CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Home3'),
                  ),
                ),
                Scaffold(
                  drawer: const CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Home4'),
                  ),
                ),
                if (userManager.adminEnabled) ...[
                  AdminUsersScreen(),
                  Scaffold(
                    drawer: const CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('Pedidos'),
                    ),
                  ),
                ]
              ],
            );
          },
        ));
  }
}
