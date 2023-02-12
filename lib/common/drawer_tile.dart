import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/page_manager.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key, required this.icon, required this.title, required this.page})
      : super(key: key);

  final IconData icon;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    //para mudar o estado, use o watch (fora da função)
    final int currentPage = context.watch<PageManager>().page;
    return InkWell(
      //dentro da função, utilize o read
      onTap: () => context.read<PageManager>().setPage(page),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                icon,
                size: 32,
                color: currentPage == page ? primaryColor : Colors.grey,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: currentPage == page ? primaryColor : Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
