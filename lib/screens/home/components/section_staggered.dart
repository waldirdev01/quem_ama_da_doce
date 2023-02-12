import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quem_ama_da_doce/screens/home/components/item_tile.dart';
import 'package:quem_ama_da_doce/screens/home/components/section_header.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../models/home_section/section.dart';

class StaggeredSection extends StatelessWidget {
  const StaggeredSection({Key? key, required this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section: section),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 600,
              child: MasonryGridView.count(
                padding: EdgeInsets.zero,

                scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: section.items.length,
                itemBuilder: (context, index) {
                  return ItemTile(
                      height:( index % 3 + 1) * 30,
                      item: section.items[index], valueKey: ValueKey(section.items[index],));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
