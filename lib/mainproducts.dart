import 'package:flutter/material.dart';
import 'product_detail.dart';
class MainProducts extends StatelessWidget {
  const MainProducts({super.key, required this.price, required this.description, required this.rating, required this.icon, required this.img, required this.title });
final ImageProvider img;
  final String price;
  final String title;
  final double rating;
  final IconData icon;
  final String description;


  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailScreen(
            title :title,
            price: price,
            description: description,
            img: img,
            rating: rating,
          )));
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: Image(image: img,
                fit: BoxFit.cover,
                ),
              ),
              Text('Price : $price'),
              Text(title),
              Row(
                children: [Text('$rating'), Icon(icon)],
              )
            ],
          ),
        ),
      ),
    );
  }
}

