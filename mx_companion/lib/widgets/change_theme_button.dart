import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '';
import '../app_theme.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged:(value){
      final provider = Provider.of<ThemeProvider>(context, listen: false);
      provider.toggleTheme(value);
      },
    );
  }
}
