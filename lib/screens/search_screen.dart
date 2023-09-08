import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_club/screens/profile_screnn.dart';
import 'package:social_club/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(labelText: "Search for a user"),
          onFieldSubmitted: (value) {
            setState(() {
              isShowUsers = true;
            });
            print(value);
          },
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("users")
            .where("username", isGreaterThanOrEqualTo: searchController.text)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator.adaptive();
          }
          return isShowUsers
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ["uid"]),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ["photoUrl"]),
                        ),
                        title: Text((snapshot.data! as dynamic).docs[index]
                            ["username"]),
                      ),
                    );
                  },
                )
              : FutureBuilder(
                  future: FirebaseFirestore.instance.collection("posts").get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                    return MasonryGridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 3,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => Image.network(
                            snapshot.data!.docs[index]["postUrl"]));
                  },
                );
        },
      ),
    );
  }
}
