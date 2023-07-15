//هذه الصفحة خاصة بالوجبات داخل الاصناف

import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen({super.key, required this.availbleMeals});

  static const routeName = 'category_meals';
  final List<Meal> availbleMeals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealssScreenState();
}

class _CategoryMealssScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayMeal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // CategoryItems >== selectCategory <== من Arg هنا رح استقبل قيم
    final routArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routArg['id'];
    categoryTitle = routArg['title']!;

/* متى ما تحقق هذا الشرط فرجع كل عنصر يحقق هذا الشرط
باخذ العناصر الي بتحقق شرط معين  ومن ثم برجع بسويها قائمة وبخزنها في متغير==> عملت فلترة
رح يمر على قائمة الوجبات وبتححق هل هي موجودة ضمن تصنيف الي اخترته ورح يعرضها ==> ايطالي ,الماني
فقط الوجبات الخاصة بالتصنيف بعرضها
 */

    displayMeal = widget.availbleMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
  }

/*id تحذف العنصر الذي يطابق ال
 displayMeal ==< انشا متغير ومررة في 
 displayMeal ==> where اصلا هي مفلترة عن طريق 
*/
  void _removeMeal(String mealId) {
    setState(
      () {
        displayMeal.removeWhere((meal) => meal.id == mealId);
        print('removeMeal ==> $mealId');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (context, index) {
          //MealItem مررت القيم لل
          return MealItem(
            imageUrl: displayMeal[index].imageUrl,
            title: displayMeal[index].title,
            duration: displayMeal[index].duration,
            complexity: displayMeal[index].complexity,
            affordability: displayMeal[index].affordability,
            id: displayMeal[index].id,
          );
        },
        itemCount: displayMeal.length,
      ),
    );
  }
}
