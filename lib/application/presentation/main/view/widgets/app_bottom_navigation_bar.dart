import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final Function(int) onSelected;
  final List<IconData> items;
  final int selectedIndex;

  const AppBottomNavigationBar(
      {super.key,
      required this.onSelected,
      required this.items,
      this.selectedIndex = 0})
      : assert(items.length > 2),
        assert((items.length % 2) == 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(),
      child: Material(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
        child: Row(
          children: _createNavBarItemsList(),
        ),
      ),
    );
  }

  _createNavBarItemsList() {
    List<Widget> list = [];
    for (int i = 0; i < items.length; i++) {
      IconData iconData = items[i];
      list.add(
        Expanded(
          child: Center(
            child: IconButton(
              icon: Icon(
                iconData,
                color:
                    selectedIndex == i ? AppTheme.appBlue : AppTheme.greyLight,
              ),
              onPressed: () {
                onSelected(i);
              },
            ),
          ),
        ),
      );
    }

    list.insert(
      items.length ~/ 2,
      Expanded(
        child: Center(
          child: SizedBox(
            height: 48,
            width: 48,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
    return list;
  }
}
