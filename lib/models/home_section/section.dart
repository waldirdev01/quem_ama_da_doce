import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quem_ama_da_doce/models/home_section/section_item.dart';

class Section {
  String name;
  String type;
  List<SectionItem> items;

  Section.fromDocument(DocumentSnapshot document)
      :
        name = document['name'] as String,
        type = document['type'] as String,
        items = (document['items'] as List).map((image) =>
            SectionItem.fromMap(image as Map<String, dynamic>)).toList();

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}