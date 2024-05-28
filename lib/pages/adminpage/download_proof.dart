import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProof extends StatefulWidget {
  //email of user
  final String email;
  const DownloadProof({super.key, required this.email});

  @override
  State<DownloadProof> createState() => _DownloadProofState();
}

class _DownloadProofState extends State<DownloadProof> {
  //variable containing files
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles =
        FirebaseStorage.instance.ref('/files/${widget.email}/').list();
  }

  Future downloadFile(Reference ref) async {
    //download url for the files
    final url = await ref.getDownloadURL();

    final tempDir = await getExternalStorageDirectory();
    final path = '${tempDir!.path}/${ref.name}';
    await Dio().download(url, path);

    print(path);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Downloaded ${ref.name}'),
      backgroundColor: const Color(0xFF3D8361),
    ));
  }

  //display list of files
  Widget files() {
    return FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;

            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];

                return ListTile(
                  title: Text(file.name),
                  trailing: IconButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: const Color(0xFF3D8361)),
                      onPressed: () {
                        downloadFile(file);
                      },
                      icon: const Icon(Icons.download)),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error occurred"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Proofs of Legitimacy",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF1C6758),
          foregroundColor: const Color(0xFFEEF2E6), // Dark green
        ),

        //details of friend
        body: files());
  }
}
