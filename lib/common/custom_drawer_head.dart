import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_user/app_user_manager.dart';


class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (_, userManager, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
              child: Text(
                'Quem Ama\nDá Doce',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.fromLTRB(18, 0, 0, 0),
              child: Text(
                'Olá, ${userManager.appUser?.name ?? 'Visitante.'}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (userManager.isLoggedIn) {
                  userManager.signOut();
                } else {
                  Navigator.of(context).pushNamed('/login');
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                child: Text(
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se >',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
