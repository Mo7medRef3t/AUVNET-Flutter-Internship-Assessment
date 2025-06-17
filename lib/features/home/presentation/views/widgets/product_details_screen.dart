import 'package:flutter/material.dart';
import 'package:auvnet/features/products/data/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name, style: GoogleFonts.poppins())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl.isNotEmpty
                  ? product.imageUrl
                  : 'https://via.placeholder.com/300',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${product.name}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Category: ${product.category}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Text(
              'Price: ${product.price.toString()}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
