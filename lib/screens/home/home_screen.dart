import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quem_ama_da_doce/models/home_section/home_manager.dart';
import 'package:quem_ama_da_doce/screens/home/components/section_staggered.dart';

import '../../common/custom_drawer/custom_drawer.dart';
import 'components/section_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do Daniel'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeManager>(builder: (_, homeManager, __) {
                final List<Widget> children =
                    homeManager.sections.map<Widget>((section) {
                  switch (section.type) {
                    case 'Staggered':
                      return StaggeredSection(
                        section: section,
                      );
                    case 'List':
                      return SectionList(
                        section: section,
                      );

                    default:
                      return Container();
                  }
                }).toList();
                return SliverList(
                    delegate: SliverChildListDelegate(
                  children,
                ));
              })
            ],
          ),
        ],
      ),
    );
  }
}
