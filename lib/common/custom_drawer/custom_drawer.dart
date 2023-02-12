import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_user/app_user_manager.dart';
import '../custom_drawer_head.dart';
import '../drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 203, 236, 241),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
            ),
            child: ListView(
              children:   [
                const CustomDrawerHeader(),
                const Divider(),
                const DrawerTile(
                  icon: Icons.home,
                  title: 'Início', page: 0,
                ),

                const DrawerTile(
                  icon: Icons.list,
                  title: 'Produtos', page: 1,
                ),
                const DrawerTile(
                  icon: Icons.playlist_add_check,
                  title: 'Meus Pedidos', page: 2,
                ),
                const DrawerTile(
                  icon: Icons.location_on,
                  title: 'Lojas', page: 3,
                ),
                Consumer<UserManager>(
                  builder: (_, userManager, __){
                    if(userManager.adminEnabled){
                      return Column(
                        children: const <Widget>[
                          Divider(),
                           DrawerTile(
                            icon: Icons.settings,
                            title: 'Usuários',
                            page: 4,
                          ),
                           DrawerTile(
                            icon: Icons.settings,
                            title: 'Pedidos',
                            page: 5,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );

  }
}
