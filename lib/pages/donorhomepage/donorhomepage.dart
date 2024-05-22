import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23project/models/organization_model.dart';
import 'package:cmsc23project/pages/donateformpage/donate_form.dart';
import 'package:cmsc23project/providers/organization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  
  //TODO use Organization model 
  List<String> organizations = [
    'Hope Haven Organization',
    'Compassion Collective',
    'Brighter Futures Initiative',
    'Hearts United Charity',
    'Empowerment Alliance',
    'Unity Outreach Network',
    'Serenity Foundation',
    'Impactful Change Foundation',
    'Renewed Vision Charity',
    'Harmony Aid Organization'
  ];
  
  List<String> filteredOrganizations = [];

  @override
  void initState() {
    super.initState();
    filteredOrganizations = organizations;
    _searchController.addListener(_filterOrganizations);
  }

  void _filterOrganizations() {
    setState(() {
      filteredOrganizations = organizations
          .where((org) => org.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
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
      drawer: const Placeholder(),
      backgroundColor: const Color(0xFFEEF2E6),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            // automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Color(0xFFEEF2E6)),
            backgroundColor: Color(0xFF093731),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
               titlePadding: EdgeInsets.only(left: 0, bottom: 16), // REMOVE PADDING SO THAT CENTER IS NOT OFFSET
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Donate Now!", style: TextStyle(color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold)),
                  Text(
                    "Scroll to explore organizations",
                    style: TextStyle(color: Color(0xFFEEF2E6), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar( // TODO use SliverPersistentHeader instead pag masipag ka xdxd
            backgroundColor: const Color(0xFFEEF2E6),
            automaticallyImplyLeading: false,
            pinned: true,
            flexibleSpace: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBar(
                  controller: _searchController,
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFD6CDA4)),
                  leading: const Icon(Icons.search, color: Color(0xFF093731)),
                  hintText: "Search organization...",
                  hintStyle: MaterialStateProperty.all(const TextStyle(
                    color: Color(0xFF093731),
                  )),
                ),
              ),
          ),
          stream()
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //         child: Card(
          //           clipBehavior: Clip.hardEdge,
          //           child: InkWell(
          //             splashColor: const Color(0xFF3D8361).withAlpha(100),
          //             onTap: () {
          //               debugPrint(filteredOrganizations[index]);
          //               Navigator.pushNamed(context, "/donor/donate");
          //             },
          //             child: SizedBox(
          //               width: double.infinity,
          //               height: 150,
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Center(
          //                   child: Text(
          //                     filteredOrganizations[index],
          //                     style: const TextStyle(
          //                       fontSize: 15,
          //                       fontWeight: FontWeight.bold,
          //                       color: Color(0xFF093731),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //     childCount: filteredOrganizations.length,
          //   ),
          // ),
        ]
      )
    );
  }

//stream builder widget
  Widget stream() {

    // access organizations list 
    Stream<QuerySnapshot> orgsStream = context.watch<OrganizationProvider>().organization;

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
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData) {
          return emptyOrganizations();
        } else if (snapshot.data!.docs.isEmpty) {
          return emptyOrganizations();
        }

        // render if not empty
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Organization org = Organization.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);

              org.id = snapshot.data?.docs[index].id;

              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      splashColor: const Color(0xFF3D8361).withAlpha(100),
                      onTap: () {
                        debugPrint(filteredOrganizations[index]);
                        Navigator.pushNamed(context, "/donor/donate");
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              org.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF093731),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
            },
            childCount: snapshot.data!.docs.length,
          )
        );
      },
    );
  }

  // to render if no organizations
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
}
