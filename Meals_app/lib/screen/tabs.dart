import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:mealapp/provider/mealprovider.dart';
import 'package:mealapp/screen/catagories.dart';
import 'package:mealapp/screen/filters.dart';
import 'package:mealapp/screen/meals.dart';
//import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widget/maindrawer.dart';
//import 'package:mealapp/data/dummiesdata.dart';
import 'package:mealapp/provider/favouriteprovider.dart';
import 'package:mealapp/provider/filterprovider.dart';

const kinitialfilter = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class Tabscreen extends ConsumerStatefulWidget {
  const Tabscreen({super.key});
  @override
  ConsumerState<Tabscreen> createState() {
    return _Tabscreen();
  }
}

class _Tabscreen extends ConsumerState<Tabscreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setscreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctn) => const Filterscreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final avaliablemeal = ref.watch(filtermealprovider);

    Widget activepage = Catagoryscreen(
      // ontogglemeal: _toglemealfavourite,
      avaliablemeal: avaliablemeal,
    );
    var activepagetitle = 'Categories';
    var favouritemeal = ref.watch(favouriteprovider);
    if (_selectedPageIndex == 1) {
      activepage = Mealscreen(
        meals: favouritemeal, //_favoriteMeals,
        //ontogglemeal: _toglemealfavourite,
      );
      activepagetitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer: Maindrawer(
        onselectscreen: _setscreen,
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
