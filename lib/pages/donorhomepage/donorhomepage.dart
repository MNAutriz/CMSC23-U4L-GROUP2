import 'package:cmsc23project/pages/donateformpage/donate_form.dart';
import 'package:cmsc23project/pages/donorprofilepage/donor_profile_page.dart';
import 'package:flutter/material.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  int _selectedIndex = 0;

  // TODO: use SliverAppBar for cool animation
  @override
  Widget build(BuildContext context) {
    // hardcoded para lang makita listview
    List<String?> organizations = [
      'Organization 1',
      'Organization 2',
      'Organization 3',
      'Organization 4',
      'Organization 5',
      'Organization 6',
      'Organization 7',
      'Organization 8',
      'Organization 9',
      'Organization 10',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2E6),
      appBar: AppBar(
        title: const Text("Donor's View",
            style: TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF093731),
        iconTheme: const IconThemeData(color: Color(0xFFEEF2E6)),
      ),
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFF093731),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          height: 200,
          padding: const EdgeInsets.symmetric(
            vertical: 50.0,
          ),
          width: double.infinity,
          child: const Column(
            children: [
              Center(
                  child: Text("Donate Now!",
                      style: TextStyle(
                          color:  Color(0xFFEEF2E6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              Center(
                child: Text("Choose an organization below",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFFEEF2E6))),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: organizations.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Color(0xFF3D8361).withAlpha(100),
                    onTap: () {
                      debugPrint(organizations[index]);
                      Navigator.pushNamed(context, "/donor/donate");
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("${organizations[index]}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        )
      ]),
    );
  }
}