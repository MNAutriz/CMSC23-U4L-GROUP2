import 'package:flutter/material.dart';

class DonorView extends StatefulWidget {
  const DonorView({super.key});

  @override
  State<DonorView> createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  @override
  Widget build(BuildContext context) {
    // hardcoded para lang makita listview
    List organizations = [
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF093731),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          ElevatedButton(
            onPressed: (){},
            child: const Icon(Icons.person, color: Color(0xFF093731)),
          )
        ]
      ),
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFF093731),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          padding: const EdgeInsets.symmetric(
            vertical: 50.0,
          ),
          width: double.infinity,
          child: const Column(
            children: [
              Center(
                  child: Text("Donate Now!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              Center(
                child: Text("Choose an organization below",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
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
    // bottomNavigationBar: BottomNavigationBar(
    //     backgroundColor: const Color(0xFF093731),
    //     selectedItemColor: Colors.white,
    //     unselectedItemColor: Colors.white.withOpacity(0.6),
    //     items: const [
    //       BottomNavigationBarItem(
    //         backgroundColor: Color(0xFF093731),
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         backgroundColor: Color.fromARGB(255, 56, 179, 26),
    //         icon: Icon(Icons.favorite),
    //         label: 'Donate',
    //       ),
    //       BottomNavigationBarItem(
    //           backgroundColor: Color.fromARGB(255, 56, 179, 26),
    //           icon: Icon(Icons.person),
    //           label: "Profile")
    //     ]),
  }
}
