import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temdex/Data/data_provider.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  late List<String> profileTypes;
  late String selectedValue;
  late bool isDark;
  @override
  void initState() {
    super.initState();
    profileTypes = ["Normal", "Luma", "Stickers"];
    selectedValue = ref.read(profileImageProvider);
    isDark = ref.read(colorProvider)[0] == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          pinned: true,
          expandedHeight: 350,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 2,
            title: Text(
              "Settings",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color),
            ), // centerTitle: true,
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDark,
            onChanged: (value) {
              var x = ref.read(colorProvider.notifier);
              x.toggleBrightness();
              x.changeColor(Colors.blue);
              setState(() {
                isDark = value;
              });
            },
          ),
          ListTile(
            leading: Text("Change the type of image",
                style: Theme.of(context).textTheme.titleMedium),
            trailing: SizedBox(
              width: 140,
              height: 50,
              child: DropdownButtonFormField(
                elevation: 2,
                // underline: SizedBox(),
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                hint: const Text('Select Item'),
                items: profileTypes
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                    GetStorage().write("profiletype", value);
                    ref
                        .read(profileImageProvider.notifier)
                        .update((state) => state = value);
                  });
                },
              ),
            ),
          )
        ]))
      ]),
    );
  }
}
