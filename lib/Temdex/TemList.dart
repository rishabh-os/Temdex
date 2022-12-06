import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temdex/AppDrawer.dart';
import 'package:temdex/Temdex/SearchTems.dart';
import 'package:temdex/Temdex/TemtemCard.dart';
import 'package:temdex/Data/data_provider.dart';

class TemList extends ConsumerStatefulWidget {
  const TemList({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _TemListState();
}

class _TemListState extends ConsumerState<TemList> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    var x = ref.read(temtemProvider.notifier);
    x.getData();
    var y = ref.read(traitProvider.notifier);
    y.getData();
    var z = ref.read(techniqueProvider.notifier);
    z.getData();
  }

  @override
  Widget build(BuildContext context) {
    var x = ref.watch(temtemProvider);
    return Scaffold(
      drawer: const AppDrawer(),
      floatingActionButton: const SearchAllFAB(),
      resizeToAvoidBottomInset: false,
      body: (x.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            )
          : CustomScrollView(slivers: [
              const SliverAppBar(
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Temdex', textScaleFactor: 1),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(x
                    .map((e) => TemtemCard(
                        temNumber: e.number,
                        temName: e.name,
                        temTypes: e.types))
                    .toList()),
              ),
            ]),
    );
  }
}
