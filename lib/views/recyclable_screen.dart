import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class RecyclableScreen extends StatelessWidget {
  const RecyclableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Scrap'),
      ),
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Greetings, ${GetStorage().read('user')['user']['name']},',
              style: GoogleFonts.aBeeZee(fontSize: 15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'What would you like to sell?',
              style: GoogleFonts.aBeeZee(fontSize: 25),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 100,
                    width: 125,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.book),
                        const Text('Papers'),
                      ],
                    )),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 100,
                    width: 125,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.bottleWater),
                        const Text('Plastic'),
                      ],
                    )),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 100,
                    width: 125,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.glassWater),
                        const Text('News Paper'),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 100,
                    width: 125,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.laptop),
                        const Text('E-Waste'),
                      ],
                    )),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 100,
                    width: 125,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.recycle),
                        const Text('Others'),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Book Your Slot')),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                'Terms and Conditions Apply',
                style: TextStyle(fontSize: 10),
              )),
        ),
      ])),
    );
  }
}
