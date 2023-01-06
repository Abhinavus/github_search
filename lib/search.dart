
import 'dart:ui';

import 'package:flutter/material.dart';

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

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (searchController) {
            // Trigger a search when the text changes
            fetchAlbum(searchController);}

        ),
      ),
      body: searchController.text.isEmpty ? Center(child: CircularProgressIndicator(),): FutureBuilder(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Display the search results in a list view
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
          } else {
            // Display a loading spinner while the search results are being fetched
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}