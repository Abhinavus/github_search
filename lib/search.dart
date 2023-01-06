import 'package:flutter/material.dart';
import 'package:github_search/repo.dart';

import 'api.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<Post> futureAlbum;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(searchController.text);
  }

  Future<Post> getalbum() async {
    return futureAlbum = fetchAlbum(searchController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            controller: searchController,
            onChanged: (searchController) {
              setState(() {
                futureAlbum = getalbum();
              });
            }),
      ),
      body: FutureBuilder(
        future: futureAlbum,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(snapshot.data!.avatarUrl),
                    title: Text(snapshot.data!.login),
                    trailing: Chip(
                      label: Text(snapshot.data!.publicRepos.toString()),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
