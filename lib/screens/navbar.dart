import 'package:flutter/material.dart';

// Define a custom icon type to pass the icon data
typedef NavIconBuilder = Widget Function(BuildContext);

class NavBarIcon {
  final NavIconBuilder builder;
  final String label;

  NavBarIcon({required this.builder, required this.label});
}

class NavBar extends StatelessWidget {
  final Color backgroundColor;
  final List<NavBarIcon> icons;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const NavBar({
    super.key,
    required this.backgroundColor,
    required this.icons,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    assert(icons.length > 1, 'There must be at least two icons in the nav bar');

    return Container(
      width: double.infinity,
      height: 88,
      padding: const EdgeInsets.only(top: 11, bottom: 27),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: icons.asMap().entries.map((entry) {
          int idx = entry.key;
          NavBarIcon icon = entry.value;
          bool isSelected = idx == selectedIndex;

          return GestureDetector(
            onTap: () => onItemSelected(idx),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon.builder(context),
                const SizedBox(height: 4),
                Text(
                  icon.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF77FFC3)
                        : const Color(
                            0xFFE9EEFF), // Highlight the selected icon
                    fontSize: 10,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
