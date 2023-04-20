import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 172, 172, 172),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 242, 242, 242),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                icon: const Icon(
                  Icons.settings_applications,
                  color: Color.fromARGB(255, 86, 133, 94),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: const _PlantCardBody());
  }
}

class _PlantCardBody extends StatelessWidget {
  const _PlantCardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Center(
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 142, 142, 142),
            radius: 92,
            child: CircleAvatar(
              backgroundImage: AssetImage('images/plant1.jpg'),
              radius: 90,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text('Name'),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 113, 169, 122),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.water_drop_outlined,
                  color: Colors.white,
                ),
                Text(
                  'When watering?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ExpansionTile(
            leading: const Icon(Icons.edit),
            title: Text(
              'Diary',
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 86, 133, 94),
              ),
            ),
            children: const [
              ListTile(
                title: TextField(
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                    hintText: '...',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
