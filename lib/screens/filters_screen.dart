// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() =>
      _FiltersScreenState();
}

class _FiltersScreenState
    extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _glutenFreeFilterSet =
        activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet =
        activeFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet =
        activeFilters[Filter.vegetarian]!;
    _veganFilterSet = activeFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          Navigator.of(context).pop();
          return false;
        },
        child: Column(
          children: [
            mySwitchListTile(
              'Gluten-free',
              _glutenFreeFilterSet,
              'Only include gluten-free meals.',
              (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
            ),
            mySwitchListTile(
              'Lactose-free',
              _lactoseFreeFilterSet,
              'Only include lactose-free meals.',
              (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            mySwitchListTile(
              'Vegetarian',
              _vegetarianFilterSet,
              'Only include vegetarian meals.',
              (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
            ),

            mySwitchListTile(
              'Vegan',
              _veganFilterSet,
              'Only include vegan meals.',
              (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  SwitchListTile mySwitchListTile(
    String txt,
    bool val,
    String subText,
    void Function(bool) updateFn,
  ) {
    return SwitchListTile(
      value: val,
      onChanged: updateFn,
      title: Text(
        txt,
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subText,
        style: Theme.of(
          context,
        ).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 34,
        right: 22,
      ),
    );
  }
}
