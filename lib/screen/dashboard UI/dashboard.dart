import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nepaliapp/utils/utils.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreData =
        FirebaseFirestore.instance.collection('Business').snapshots();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSearchBar(),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Trending Businesses',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: StreamBuilder(
                stream: firestoreData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    snapshot.data!.docs[index]["ImageUrl"],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.docs[index]
                                    ["ImageUrl"],
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error),
                                ),
                              ),
                            ),
                            title:
                                Text('${snapshot.data!.docs[index]["Name"]}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '${snapshot.data!.docs[index]["Category"]}'),
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    int rating =
                                        snapshot.data!.docs[index]["Rating"];
                                    return Icon(
                                      starIndex < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: utils.primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
