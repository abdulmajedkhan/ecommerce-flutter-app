import 'package:flutter/material.dart';
class DisountContainers extends StatelessWidget {
  const DisountContainers({super.key, required this.title, required this.descriptionOffers});
  final String title;
  final descriptionOffers;



  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: 400,
            height: 220,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xFFE0EAEB),
                borderRadius: BorderRadius.circular(30)),
            //TODO:  materials inside in the discountOffers
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),


                Text(
                  '$descriptionOffers',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: const Color(0xFF386B6F),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                        child: Text(
                          'Shop Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
