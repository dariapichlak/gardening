import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPlantPage extends StatelessWidget {
  const AddPlantPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        backgroundColor: const Color.fromARGB(255, 86, 133, 94),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('images/plantimage.jpg'),
              radius: 100,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Plant Name',
                hintStyle: GoogleFonts.dancingScript(
                    textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 218, 218, 218),
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.water),
                    Text('Watering'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Diary',
            ),
          ),
        ],
      ),
    );
  }
}
