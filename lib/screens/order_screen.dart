import 'package:flutter/material.dart';
import '../widget/order_data.dart';

class OrderScreen extends StatefulWidget {
  static const String id = 'Order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Today Delivery Orders',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _rowHeader(flex: 1, text: ' SN'),
                _rowHeader(flex: 1, text: ' Name'),
                _rowHeader(flex: 1, text: ' Order Id'),
                _rowHeader(flex: 1, text: 'Order From'),
                _rowHeader(flex: 1, text: 'Order Status'),
                _rowHeader(flex: 1, text: 'Order Time'),
                _rowHeader(flex: 1, text: 'Rider name'),
                _rowHeader(flex: 1, text: 'Appoint Rider'),
                _rowHeader(flex: 1, text: 'View More'),
              ],
            ),
            const OrderData()
          ]),
    );
  }

  Widget _rowHeader({int? flex, String? text}) {
    return Expanded(
      flex: flex!,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            color: Colors.grey.shade400),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
