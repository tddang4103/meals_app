import 'package:flutter/material.dart';
import 'package:meals_app/categories.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/filters.dart';
import 'package:meals_app/main_drawer.dart';
import 'package:meals_app/meals.dart';
import 'package:meals_app/models/meal.dart';

const filter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarianFree: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  Map<Filter, bool> _selectedFilter = filter;

  final List<Meal> _favoriteMeals = [];

  void _showInfoMessge(String messge) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messge)));
  }

  void _toggleFavoriteStatus(Meal meal) {
    var isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessge('Đã xóa khỏi mục yêu thích');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessge('Đã thêm vào mục yêu thích');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String indentifier) async {
    if (indentifier == 'filters') {
      Navigator.pop(context);
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(filter: _selectedFilter),
        ),
      );
      setState(() {
        _selectedFilter = result ?? filter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals =
        dummyMeals.where((meal) {
          if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }

          if (_selectedFilter[Filter.vegetarianFree]! && !meal.isVegetarian) {
            return false;
          }
          if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();
    Widget activePage = CategoriesScreen(
      onSelectedFavories: _toggleFavoriteStatus,
      filterMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onSelectedFavories: _toggleFavoriteStatus,
      );
      activePageTitle = 'Your favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectedDrawer: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
