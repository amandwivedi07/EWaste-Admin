import 'package:admin/widget/rider_order_data.dart';
import 'package:flutter/material.dart';

class RiderReport extends StatelessWidget {
  final String? date;
  final String? riderUid;
  static const String id = 'rider-report';
  const RiderReport({this.riderUid, this.date, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Rider Report',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  _rowHeader(flex: 1, text: ' SN'),
                  _rowHeader(flex: 1, text: 'Order date'),
                  _rowHeader(flex: 1, text: ' Name'),
                  _rowHeader(flex: 1, text: ' Order Id'),
                  _rowHeader(flex: 1, text: ' Order Total'),
                  _rowHeader(flex: 1, text: 'Delivery Total'),
                  _rowHeader(flex: 1, text: 'Rider name'),
                  _rowHeader(flex: 1, text: 'Total'),
                  _rowHeader(flex: 1, text: 'Get DTotal'),
                ],
              ),
              RiderReportData(
                date: date,
                riderUid: riderUid,
              )
            ]),
      ),
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
