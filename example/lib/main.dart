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
          spacing: 5,
          children: [
            FlexiChip(
              style: const FlexiChipStyle.outlined(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderWidth: 2,
              ),
              selectedStyle: FlexiChipStyle.stated((states) {
                const base = FlexiChipStyle.elevated(
                  useCheckmark: true,
                  color: Colors.green,
                  avatarColor: Colors.black54,
                );
                if (states.contains(MaterialState.pressed)) {
                  return base.copyWith(elevation: 5);
                }
                return base;
              }),
              // style: const FlexiChipStyle.outlined(
              //   color: Colors.green,
              //   borderWidth: 2,
              // ),
              // activeStyle: const FlexiChipStyle.elevated(
              //   useCheckmark: true,
              //   color: Colors.green,
              // ),
              label: const Text('Dart'),
              avatarText: const Text('DT'),
              // trailing: const Icon(Icons.close),
              // disabled: true,
              selected: _selected,
              onSelected: (selected) => setState(() => _selected = selected),
              onDeleted: () => print('delete'),
            ),
            FlexiChip(
              // style: const FlexiChipStyle.outlined(),
              selectedStyle: const FlexiChipStyle.outlined(
                useCheckmark: true,
                color: Colors.red,
                borderWidth: 2,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                foregroundStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              label: const Text('TS'),
              // trailing: const Icon(Icons.calendar_month),
              tooltip: 'Typescript',
              // disabled: true,
              selected: _selected,
              onSelected: (selected) => setState(() => _selected = selected),
            ),
          ],
        ),
      ),
    );
  }
}
