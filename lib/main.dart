import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // المستخدم لما يضع فلاتر معينة سيتم تحديثها ووضعها هنا
  Map<String, bool> _filterذs = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarin': false,
  };

  List<Meal> _availbleMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];
  

  void _setFilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;

/*
بعمل فلترة لقائمة المؤكولات 
بعمل شرط اذا المستخدم اختار نوع الفلتر 
وكانت الاكلة ليست خالية من النوع سواء ==>GLUTEN,VEGAN..
واذا تحققن الشرطين لا ترجعة
*/
      _availbleMeals = dummyMeals.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarin'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

/*
_favoriteMeals تمر على كل  عنصر في 
 تبعة indexتنفذ شرط معين وكل عنصر يوافقة ترجع ال 

 ستقوم بحذفة والا ستضيفة Favorits اذا كان العنصر موجود في قائمة 
*/
  void _togelFavorits(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    //اذا تحقق الشرط احذفة
    if (existingIndex >= 0) {
      _favoriteMeals.removeAt(existingIndex);
    } else {
      //غير ذلك ضيفة
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

/*
function ستستدعى هاي  Favorite عند الضغط على علامة 
_favoriteMeals هل هاي الوجبة الي ضغط عليها موجودة في 
 يطابق هذا الشرط _favoriteMealsهل هناك اي عنصر ضمن ال 
 floatingActionButton بستفيد منها اني رح اغير ايقونة 
*/
  bool _isMealFavorites(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        shadowColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        //هنا مررت قيم عن طريق السكرينات
        '/': (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availbleMeals: _availbleMeals,
            ),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(
            togelFavorits: _togelFavorits, isFavorites: _isMealFavorites),
        FiltersScreen.routName: (ctx) =>
            FiltersScreen(saveFilters: _setFilters, currentFilters: _filters),
      },
      // home: const CategoriesScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Meal App'),
      ),
      body: null,
    );
  }
}
