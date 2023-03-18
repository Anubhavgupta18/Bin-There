import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecyclableScreen extends StatelessWidget {
  const RecyclableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Scrap'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: [
              Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(child: Text('News Paper')),
                ),
              ),
              Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(child: Text('News Paper')),
                ),
              ),
              Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(child: Text('News Paper')),
                ),
              ),
              Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(child: Text('News Paper')),
                ),
              ),
              Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(child: Text('News Paper')),
                ),
              )
            ],
          )
        ]),
      )),
    );
  }
}
