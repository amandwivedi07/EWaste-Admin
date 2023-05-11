import 'package:admin/widget/rider_data.dart';
import 'package:flutter/material.dart';

class RiderScreen extends StatefulWidget {
  static const String id = 'Rider';
  const RiderScreen({Key? key}) : super(key: key);

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  bool? selectedButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rider',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selectedButton == true
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade500)),
                        onPressed: () {
                          setState(() {
                            selectedButton = true;
                          });
                        },
                        child: const Text('Approved')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selectedButton == false
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade500)),
                        onPressed: () {
                          setState(() {
                            selectedButton = false;
                          });
                        },
                        child: const Text('Rejected')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selectedButton == null
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade500)),
                        onPressed: () {
                          setState(() {
                            selectedButton = null;
                          });
                        },
                        child: const Text('All')),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _rowHeader(flex: 1, text: 'Rider Name'),
                _rowHeader(flex: 1, text: 'Rider Address'),
                _rowHeader(flex: 1, text: 'Mobile'),
                _rowHeader(flex: 1, text: 'Action'),
                _rowHeader(flex: 1, text: 'View More'),
              ],
            ),
            RiderData(
              approveStatus: selectedButton,
            )
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
