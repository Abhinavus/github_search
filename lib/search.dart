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
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    futureAlbum = fetchAlbum('abhinavu');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
              Future.delayed(Duration(milliseconds: 100), () {
                setState(() {
                  futureAlbum = getalbum();
                });
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
                if (snapshot.error.toString() ==
                    'Exception: Failed to load album') {
                  return Text('No user found');
                } else {
                  return Text('Error: ${snapshot.error}');
                }
              }
              return ListView.builder(
                itemCount: snapshot.data?.totalCount,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        Image.network(snapshot.data!.items[index].avatarUrl),
                    title: Text(snapshot.data!.items[index].login),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
