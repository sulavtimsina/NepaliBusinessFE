import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nepaliapp/utils/custom_search_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreCategory =
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
                'Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No categories found.'),
                    );
                  } else {
                    // Extract unique categories
                    final uniqueCategories = <String>{};
                    for (var doc in snapshot.data!.docs) {
                      final category = doc['Category'] ?? "No Name";
                      uniqueCategories.add(category);
                    }

                    final categoryList = uniqueCategories.toList();

                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 100),
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];

                          final data = doc.data() as Map<String, dynamic>;

                          final category = data.containsKey('Category') &&
                                  data['Category'] != null
                              ? data['Category'].toString().toLowerCase()
                              : "No Name";

                          final displayCategory =
                              category[0].toUpperCase() + category.substring(1);

                          return SizedBox(
                            height: 2,
                            child: Card(
                              elevation: 4,
                              child: Center(
                                child: Text(
                                  displayCategory,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        });
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
