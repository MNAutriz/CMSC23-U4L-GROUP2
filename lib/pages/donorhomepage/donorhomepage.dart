import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:cmsc23project/pages/donateformpage/donate_form.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:cmsc23project/providers/auth_provider.dart';
import 'package:cmsc23project/screens/userview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  int _selectedIndex = 0;

  String backgroundImage =
      'https://media.istockphoto.com/id/1402801804/photo/closeup-nature-view-of-palms-and-monstera-and-fern-leaf-background.webp?b=1&s=170667a&w=0&k=20&c=oj5HjeYMh3RmxbjUNDiMfn6VSngH_-1uPIUPD7BhNus=';

  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  String _selectedOrgEmail = '';

  @override
  void initState() {
    super.initState();

    if (mounted) {
      Future.delayed(Duration.zero, () {
        // need future.delayed so that it will fetchorganizations after build phase is complete
        context.read<OrganizationProvider>().fetchOrganizations();
      });
    }

    _searchController.addListener(() {
      if (mounted) {
        // add this to prevent memory leak yeah boi
        setState(() {
          searchQuery = _searchController.text.toLowerCase();
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      backgroundColor: const Color(0xFFEEF2E6),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            iconTheme: IconThemeData(color: Color(0xFFEEF2E6)),
            backgroundColor: Color(0xFF093731),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 0, bottom: 16),
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Donate Now!",
                        style: TextStyle(
                            color: Color(0xFFEEF2E6),
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    "Scroll to explore organizations",
                    style: TextStyle(color: Color(0xFFEEF2E6), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            backgroundColor: const Color(0xFFEEF2E6),
            automaticallyImplyLeading: false,
            pinned: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBar(
                controller: _searchController,
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFD6CDA4)),
                leading: const Icon(Icons.search, color: Color(0xFF093731)),
                hintText: "Search organization...",
                hintStyle: MaterialStateProperty.all(const TextStyle(
                  color: Color(0xFF093731),
                )),
              ),
            ),
          ),
          stream()
        ],
      ),
    );
  }

  Widget stream() {
    Stream<QuerySnapshot> orgsStream =
        context.watch<OrganizationProvider>().organization;

    return StreamBuilder(
      stream: orgsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text("Error encountered! ${snapshot.error}"),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Text("Loading organizations"),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return emptyOrganizations();
        }

        var docs = snapshot.data!.docs;
        if (searchQuery.isNotEmpty) {
          docs = docs.where((doc) {
            var data = doc.data() as Map<String, dynamic>;
            var orgName = data['name'].toString().toLowerCase();
            return orgName.contains(searchQuery);
          }).toList();
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Organization org = Organization.fromJson(
                  docs[index].data() as Map<String, dynamic>);
              org.id = docs[index].id;

              return Stack(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    child: Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                            child: Image.network(backgroundImage,
                                fit: BoxFit.cover),
                            onTap: () {
                              _selectedOrgEmail = org
                                  .email; // pass email of organization to a variable
                              Navigator.pushNamed(
                                  context, '/donor/donatedrives',
                                  arguments: {
                                    'selectedOrgEmail': _selectedOrgEmail,
                                    'orgID': org.id,
                                    'orgName': org.organizationName,
                                  });

                              // include selected organization email as an argument to be used in donatedrives route
                            })),
                  ),
                ),
                Positioned.fill(
                  // so that text will fill the entire card and the center widget will center according to entire card
                  child: Center(
                    child: Text(org.organizationName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xFFEEF2E6),
                            shadows: [
                              Shadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(2, 2))
                            ])),
                  ),
                )
              ]);
            },
            childCount: docs.length,
          ),
        );
      },
    );
  }

  Widget emptyOrganizations() {
    return const SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.people),
            Text("No registered organizations yet"),
          ],
        ),
      ),
    );
  }

  Drawer get drawer => Drawer(
        child: Container(
          color: const Color(0xFFEEF2E6),
          child: ListView(padding: EdgeInsets.zero, children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF1C6758)),
                child: Text("Settings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFFEEF2E6)))),
            ListTile(
              title: const Center(
                child: Text(
                  "Log out",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF1C6758)),
                ),
              ),
              onTap: () {
                // band aid solution

                // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                context.read<UserAuthProvider>().signOut();
                Navigator.pushReplacementNamed(context, '/');

              },
            ),
          ]),
        ),
      );
}
