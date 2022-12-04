import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:temtem_wiki/Data/data_provider.dart';
import 'package:temtem_wiki/Settings.dart';
import 'package:temtem_wiki/TypeMatchups.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(child: Container()),
        Consumer(
          builder: (context, ref, child) => ListTile(
            leading: const Icon(Icons.sync),
            title: const Text("Refresh Data"),
            onTap: () {
              fToast.showToast(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.greenAccent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text("Data refreshed"),
                    ],
                  ),
                ),
                gravity: ToastGravity.BOTTOM,
                toastDuration: const Duration(seconds: 2),
              );
              var x = ref.read(temtemProvider.notifier);
              x.getData();
              var y = ref.read(traitProvider.notifier);
              y.getData();
              Navigator.of(context).pop();
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.pivot_table_chart_outlined),
          title: const Text("Type Matchups"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TypeMatchup(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text("Settings"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Settings(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
