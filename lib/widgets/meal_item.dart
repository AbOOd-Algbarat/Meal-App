//هذا الملف خاص بتنسيق الوجبات داخل الاصناف
import 'package:flutter/material.dart';
import 'package:meal_app/screens/meal_details_screen.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
  });

  final String id;
  final String title;
  final int duration;
  final String imageUrl;
  final Complexity complexity;
  final Affordability affordability;

//وحولتهن لنصوص enum complexity استخرجت قيم ال
  String get complexityText {
    return complexity == Complexity.simple
        ? 'Simple'
        : complexity == Complexity.challenging
            ? 'Challenging'
            : complexity == Complexity.hard
                ? 'Hard'
                : 'Unknown';
  }

  String get affordabilityText {
    return affordability == Affordability.affordable
        ? 'Affordable'
        : affordability == Affordability.pricey
            ? 'Pricey'
            : affordability == Affordability.luxurious
                ? 'Luxurious'
                : 'Unknown';
  }

/*
رح تنقلك لشاشة تفاصيل والمقادير
   لما يحذف الصفح id رح يقوم بارجاع thenالجزء الثاني 
 result في  idيخزن ال 
 */
  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
      MealDetailsScreen.routeName,
      arguments: id,
    )
        .then(
      (result) {
        // if (result != null) removeItem(result);
      },
    );
  }

  @override
  //خواص للكروت لداخل الاصناف
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    color: Colors.black54,
                    width: 220,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(children: [
                    const Icon(Icons.schedule),
                    const SizedBox(width: 6),
                    Text('$duration Minute'),
                  ]),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(width: 6),
                      Text(complexityText),
                    ],
                  ),
                  Row(children: [
                    const Icon(Icons.attach_money),
                    const SizedBox(width: 5),
                    Text(affordabilityText),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
