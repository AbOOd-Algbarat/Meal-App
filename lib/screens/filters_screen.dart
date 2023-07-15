import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(
      {super.key, required this.saveFilters, required this.currentFilters});

  static const routName = '/filters';

  //function ==>main وهي نفسها المررت main لاستقبال بيانات الفلتر من
  final Function saveFilters;
  final Map currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  //قيم مبدأية
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    super.initState();

    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegetarin'];
    _vegetarian = widget.currentFilters['vegan'];
  }

  Widget buildSwitchListTile(
    bool currentValue,
    String title,
    String description,
    updateValue,
  ) {
    return SwitchListTile(
      value: currentValue,
      subtitle: Text(description),
      title: Text(title),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // ignore: unused_local_variable
              final Map<String, bool> selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarin': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  _glutenFree,
                  'Gluten-Free',
                  'Only Included Gluten-Free Meals.',
                  (newvalue) {
                    setState(
                      () {
                        _glutenFree = newvalue;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  _lactoseFree,
                  'Lactose-Free',
                  'Only Included Lactose-Free Meals.',
                  (newvalue) {
                    setState(
                      () {
                        _lactoseFree = newvalue;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  _vegetarian,
                  'Vegetarian',
                  'Only Included Vegetarian Meals.',
                  (newvalue) {
                    setState(
                      () {
                        _vegetarian = newvalue;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  _vegan,
                  'Vegan',
                  'Only Included Vegan Meals.',
                  (newvalue) {
                    setState(
                      () {
                        _vegan = newvalue;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
