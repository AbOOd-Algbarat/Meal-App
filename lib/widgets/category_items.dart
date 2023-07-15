// الخاصة بالاصناف بحث يكون الكود مرتب widgetهنا وضعت ال

import 'package:flutter/material.dart';
import 'package:meal_app/screens/category_meal_screen.dart';

class CategoryItems extends StatelessWidget {
  //بمرر القيم من الاصناف
  const CategoryItems({
    super.key,
    required this.id,
    required this.title,
    required this.color,
  });

  final String id;
  final String title;
  final Color color;

//هذة الدلة  خاصة بالانتقال بين الاصناف وحتى اميزهم بمرر الايدي
  void selectCategory(BuildContext ctx) {
    print('Select Category ==>  $id');
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.4), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
