import 'package:crm_application/Provider/LeadsProvider.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../Utils/Colors.dart';

class ScheduleACallBack extends StatefulWidget {
  const ScheduleACallBack(
      {Key? key, required this.leadId, required this.authToken})
      : super(key: key);
  final String leadId;
  final String authToken;

  @override
  State<ScheduleACallBack> createState() => _ScheduleACallBackState();
}

class _ScheduleACallBackState extends State<ScheduleACallBack> {
  String scheduledDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String scheduledTime = '';
  String dropDwonvalue = 'Meeting';
  bool dropdwonEnabled = false;
  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _commentKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Schedule a call back',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Schedule Date',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2030));
                              setState(() {
                                scheduledDate =
                                    DateFormat('yyyy-MM-dd').format(date!);
                                debugPrint(date.toString());

                                debugPrint(scheduledDate);
                              });
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.33,
                                child: Text(
                                  // scheduledDate == ''
                                  //     ? 'Schedule Date'
                                  //     :
                                  scheduledDate.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Schedule Time',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            setState(() {
                              final now = DateTime.now();
                              final dt = DateTime(now.year, now.month, now.day,
                                  time!.hour, time.minute);
                              final format = DateFormat.Hm(); //"16:00"
                              format.format(dt);
                              scheduledTime = format.format(dt).toString();
                              debugPrint(scheduledTime);
                            });
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.33,
                              child: Text(
                                scheduledTime == ''
                                    ? 'Schedule Time'
                                    : scheduledTime.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Plan To Do',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        // DateTime? date = await showDatePicker(
                        //     context: context,
                        //     initialDate: DateTime.now(),
                        //     firstDate: DateTime(2000),
                        //     lastDate: DateTime(2030));
                        // setState(() {
                        //   scheduledDate =
                        //       DateFormat('d MMM y').format(date!).toString();
                        //
                        //   debugPrint(scheduledDate);
                        // });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: DropdownButtonHideUnderline(
                          child: Row(
                            children: [
                              // Text(
                              //   dropdwonEnabled ? dropDwonvalue : 'No Action',
                              //   style: const TextStyle(color: Colors.black),
                              // ),
                              DropdownButton<String>(
                                value: dropDwonvalue,
                                items: [
                                  DropdownMenuItem(
                                    child: const Text('Call Back'),
                                    value: 'Call Back',
                                    onTap: () {
                                      setState(() {
                                        dropdwonEnabled = true;
                                      });
                                    },
                                  ),
                                  DropdownMenuItem(
                                    child: const Text('Meeting'),
                                    value: 'Meeting',
                                    onTap: () {
                                      setState(() {
                                        dropdwonEnabled = true;
                                      });
                                    },
                                  ),
                                ],
                                // hint: const Align(
                                //   alignment: Alignment.centerRight,
                                //   child: Text(
                                //     "No Action",
                                //     style: TextStyle(color: Colors.grey),
                                //   ),
                                // ),
                                style: const TextStyle(
                                    color: Colors.black,
                                    decorationColor: Colors.red),
                                onChanged: (value) {
                                  setState(() {
                                    dropDwonvalue = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Comment (Optional)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Form(
                  key: _commentKey,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: commentController,
                    textCapitalization: TextCapitalization.none,
                    //focusNode: emailFocusNode,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter comment';
                    //   }
                    //   return null;
                    // },
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: themeColor,
                    ),
                    maxLines: 5,
                    autocorrect: false,
                    autofocus: false,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor, width: 2),
                      ),
                      hintText: 'Add Comment',
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // true
                //     ? Center(
                //   child: TextButton.icon(
                //     style: TextButton.styleFrom(
                //       backgroundColor: themeColor,
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 25,
                //         vertical: 9,
                //       ),
                //     ),
                //     onPressed: () {
                //       if (_formKey.currentState!.validate()) {
                //         setState(
                //               () {
                //             leadsProvider.addComment(
                //                 authToken,
                //                 widget.leadId,
                //                 formattedDate,
                //                 currentTime,
                //                 noteController.text,
                //                 context);
                //           },
                //         );
                //       } else {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             content: Text(
                //               "Please correct the errors in the form",
                //             ),
                //           ),
                //         );
                //       }
                //     },
                //     icon: const Icon(Icons.edit_sharp,
                //         color: Colors.white),
                //     label: const Text(
                //       "Create Note",
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // )
                //     : Center(
                //   child: CircularProgressIndicator(
                //     valueColor: AlwaysStoppedAnimation<Color>(
                //       Theme.of(context).primaryColor,
                //     ),
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        if (scheduledDate == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Schedule date not selected.'),
                            ),
                          );
                        } else if (scheduledTime == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Schedule time not selected.'),
                            ),
                          );
                        } else if (!dropdwonEnabled) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Plan to do is not selected.'),
                            ),
                          );
                        } else {
                          await Provider.of<LeadsProvider>(context,
                                  listen: false)
                              .scheduleCallBack(
                                  commentController.text,
                                  context,
                                  widget.leadId,
                                  dropDwonvalue,
                                  scheduledDate,
                                  scheduledTime,
                                  widget.authToken)
                              .then((value) => print(
                                  ' A call has  been scheduled for lead-id--> ${widget.leadId}'))
                              .then((value) async =>
                                  await Provider.of<LeadsProvider>(context,
                                          listen: false)
                                      .getLeadsHistory(
                                          widget.authToken, widget.leadId));
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Schedule',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: themeColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
