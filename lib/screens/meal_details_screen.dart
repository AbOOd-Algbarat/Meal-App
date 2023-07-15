import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(
      {super.key, required this.togelFavorits, required this.isFavorites});
  static const routeName = 'meal_details';

//function ==> main استقبلتها من
  final Function togelFavorits;
  final Function isFavorites;

// Ingredients and Steps <== خصائض
  Widget buildSectionTitle(String text, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  @override
  Widget build(BuildContext context) {
    //MealItem== selectMeal <== من Arg هنا رح استقبل قيم
    final mealId = ModalRoute.of(context)!.settings.arguments as String;

/*
id بدي اياه يرجع ال 
 dummyMeals الموجود في  id مع ال  id بس لازم يرجعة اذا تساوى ال
firstWhere==>يحقق هذا الشرط رجعة obj اول ما تجد 
 List ولا يمثل  
 */
    final selectedMeal = dummyMeals.firstWhere((meal) {
      return meal.id == mealId;
    });

    Widget buildContainer(Widget child) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle("Ingredients", context),
            buildContainer(
              ListView.builder(
                //Ingredients ==> الخطوات داخل
                itemBuilder: (context, index) => Card(
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.7, horizontal: 20),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle("Steps", context),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    const Divider(color: Colors.black38)
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => togelFavorits(mealId),
        child: Icon(isFavorites(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
