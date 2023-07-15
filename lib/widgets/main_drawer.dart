import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buidlListTile(String title, IconData icon, Function() tabHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).shadowColor,
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Cooking App',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.pink,
                ),
              ),
            ),
            const SizedBox(height: 20),
            buidlListTile('Meal', Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
            buidlListTile('Filters', Icons.settings, () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routName);
            }),
          ],
        ),
      ),
    );
  }
}
