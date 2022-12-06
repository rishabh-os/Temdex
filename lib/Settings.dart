import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
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
  @override
  void initState() {
    super.initState();
    profileTypes = ["Normal", "Luma", "Stickers"];
    selectedValue = ref.read(profileImageProvider);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
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
          SwitchListTile.adaptive(
            title: Text("Dark Mode",
                style: Theme.of(context).textTheme.titleMedium),
            value: isDark,
            onChanged: (value) {
              isDark
                  ? AdaptiveTheme.of(context).setLight()
                  : AdaptiveTheme.of(context).setDark();
            },
          ),
          ListTile(
            leading: Text("Change the type of image",
                style: Theme.of(context).textTheme.titleMedium),
            trailing: CustomDropdownButton2(
              offset: const Offset(0, 40),
              hint: 'Select Item',
              dropdownItems: profileTypes,
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
          )
        ]))
      ]),
    );
  }
}
