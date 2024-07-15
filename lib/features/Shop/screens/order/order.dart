import 'package:flutter/material.dart';
import 'package:nomishop/features/Shop/screens/order/widgets/order_list_items.dart';

import '../../../../util/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Orders'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(NSizes.defaultSpacing),
        child: NOrderListItems(),
      ),
    );
  }
}
