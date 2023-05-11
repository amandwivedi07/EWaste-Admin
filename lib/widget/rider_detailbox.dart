import 'package:admin/models/riders.dart';
import 'package:admin/screens/rider_report.dart';
import 'package:admin/utils/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../services/firebase_services.dart';

class RiderDetailBox extends StatefulWidget {
  final Riders rider;
  RiderDetailBox({required this.rider, Key? key}) : super(key: key);

  @override
  State<RiderDetailBox> createState() => _RiderDetailBoxState();
}

class _RiderDetailBoxState extends State<RiderDetailBox> {
  final currentDate = TextEditingController();

  // final codStatus = TextEditingController();

  // final offUptoRupeesController = TextEditingController();

  // num offerPrice = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          'Write  the date if you want to know particular date order in this form 12-12-2022'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          controller: currentDate, hintText: 'Particular Date'),
                      const SizedBox(
                        height: 20,
                      ),
                      // CustomTextField(
                      //     controller: codStatus,
                      //     hintText:
                      //         'Cod Status, if you want to know  write true or false '),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => RiderReport(
                                          riderUid: widget.rider.riderUid,
                                          date: currentDate.text,
                                        )));
                            // AdminMenuItem(
                            //   title: 'Rider Report',
                            //   route: RiderReport.id,
                            //   icon: Icons.calendar_month_outlined,
                            // );
                          },
                          child: Text('Submit'))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
