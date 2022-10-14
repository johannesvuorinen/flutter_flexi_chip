import 'package:flutter/material.dart';
import 'package:flexi_chip/flexi_chip.dart';
import 'package:theme_patrol/theme_patrol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemePatrol(
      light: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.red,
        ),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.red,
        ),
        toggleableActiveColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      builder: (context, theme) {
        return MaterialApp(
          title: 'FlexiChip',
          theme: theme.lightData,
          darkTheme: theme.darkData,
          themeMode: theme.mode,
          home: const MyHomePage(title: 'FlexiChip Example'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _selected = false;

  void _setSelected(bool value) {
    setState(() => _selected = value);
  }

  @override
  void initState() {
    super.initState();

    final style = FlexiChipStyle.filled();
    print(style.elevation);

    final resolved = FlexiChipStyle.evaluate(style, {FlexiChipEvent.pressed});
    print(resolved?.elevation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          ThemeConsumer(builder: ((context, theme) {
            return IconButton(
              onPressed: () => theme.toggleMode(),
              icon: Icon(theme.modeIcon),
            );
          })),
        ],
      ),
      body: Center(
        child: Wrap(
          spacing: 25,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Wrap(
              spacing: 10,
              children: [
                FlexiChip(
                  label: const Text('Toned Chip'),
                  selected: _selected,
                  onPressed: () => {},
                ),
                FlexiChip(
                  label: const Text('Toned Chip'),
                  leading: const Icon(Icons.calendar_month),
                  style: FlexiChipStyle.toned(),
                  selected: _selected,
                  disabled: true,
                  onPressed: () => {},
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              children: [
                FlexiChip(
                  label: const Text('Outlined Chip'),
                  style: FlexiChipStyle.outlined(),
                  checkmark: true,
                  selected: _selected,
                  onDeleted: () {},
                ),
                FlexiChip(
                  label: const Text('Outlined Chip'),
                  trailing: const Icon(Icons.calendar_month),
                  style: FlexiChipStyle.outlined(),
                  checkmark: true,
                  disabled: true,
                  selected: _selected,
                  onSelected: _setSelected,
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              children: [
                FlexiChip(
                  label: const Text('Filled Chip'),
                  avatarText: const Text('FC'),
                  style: FlexiChipStyle.filled(
                    selectedStyle: FlexiChipStyle(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  selected: _selected,
                  onSelected: _setSelected,
                  onDeleted: () {},
                ),
                FlexiChip(
                  label: const Text('Filled Chip'),
                  leading: const Icon(Icons.image),
                  style: FlexiChipStyle.filled(),
                  selected: _selected,
                  onDeleted: () {},
                  disabled: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
