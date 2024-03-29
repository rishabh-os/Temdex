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
    ref.read(temtemProvider.notifier).getData();
    ref.read(traitProvider.notifier).getData();
    ref.read(techniqueProvider.notifier).getData();
  }

  @override
  Widget build(BuildContext context) {
    var x = ref.watch(temtemProvider);
    return Scaffold(
      drawer: const AppDrawer(),
      floatingActionButton: const SearchAllFAB(),
      resizeToAvoidBottomInset: false,
      body: (x.isEmpty)
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              SliverList.builder(
                itemCount: x.length,
                itemBuilder: (context, index) {
                  var e = x[index];
                  return TemtemCard(
                      temNumber: e.number, temName: e.name, temTypes: e.types);
                },
              )

              // SliverList(
              //   delegate: SliverChildListDelegate.fixed(x
              //       .map((e) => TemtemCard(
              //           temNumber: e.number,
              //           temName: e.name,
              //           temTypes: e.types))
              //       .toList()),
              // ),
            ]),
    );
  }
}
