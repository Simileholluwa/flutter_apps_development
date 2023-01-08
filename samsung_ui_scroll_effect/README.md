## Samsung UI Scroll Effect
This package is a custom scroll view that implements Samsung's One UI scroll effect. 

## See it in action
Check example for the complete code

![](https://github.com/Simileholluwa/flutter_apps_development/blob/main/vidma_recorder_gif_23072022_172651.gif)

## Usage
* First, add the dependency to your `pubspec.yaml` file
```yaml
dependencies:
  flutter:
    sdk: flutter
  samsung_ui_scroll_effect:
```
* Supply `SamsungUiScrollEffect` to the `body` of your `Scaffold`.
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SamsungUiScrollEffectDemo',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SamsungUiScrollEffect(
        expandedTitle: Text('SAMSUNG UI SCROLL VIEW', style: TextStyle(fontSize: 32)),
        collapsedTitle: Text('Home', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.white,
        expandedHeight: 350,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        children: List<Widget>.generate(100, (index) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'List ${index + 1}',
              style: TextStyle(fontSize: 24),
            ),
          );
        }),
      ),
    );
  }
}
```
* Further explanation

| Arguments                | Parameter              | Definition                                                               |
| ------------------------ | -----------------------| -------------------------------------------------------------------------|
| `expandedTitle`          | required Widget        | The widget that is displayed when the page is not scrolled               |
| `collapsedTitle`         | required Widget        | The widget that is displayed in the app bar when the page is scrolled    |
| `backgroundColor`        | required Color         | The background color of the app bar and the flexible space               |
| `actions`                | List\<Widget\>         | A row of widgets to display at the bottom right of the flexible space    |
| `expandedHeight`         | required double        | The height of the flexible space                                         |
| `children`               | required List\<Widget\>| A column of widgets to display in the page body                          |
| `toolbarHeight`          | double                 | The app bar height. Defaults to flutter's toolbar height                 |
| `actionSpacing`          | double                 | Space between the actions widgets. Defaults to 0                         |
| `elevation`              | double                 | App bar elevation                                                        |
| `childrenPadding`        | EdgeInsetsGeometry     | Padding around the children widgets                                      |

## Issues and bugs
To report bugs, issues or request a feature click [here.](https://github.com/Simileholluwa/samsung_ui_scroll_effect_issues/issues)
