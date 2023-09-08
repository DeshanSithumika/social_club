import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_club/screens/add_post_screen.dart';
import 'package:social_club/screens/profile_screnn.dart';
import 'package:social_club/screens/search_screen.dart';

import '../screens/feed_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: Text("""Nothing shows here yet...
  I am working on it.
  """)),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
