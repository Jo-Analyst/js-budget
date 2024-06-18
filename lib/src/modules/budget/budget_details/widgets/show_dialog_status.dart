// import 'package:flutter/material.dart';
// import 'package:js_budget/src/themes/light_theme.dart';

// List<Map<String, dynamic>> situations = [
//   {'status': 'Em aberto', 'isChecked': false},
//   {'status': 'Aprovado', 'isChecked': false},
//   {'status': 'Concluído', 'isChecked': false},
// ];

// late String lastStatus;
// bool nextKeyIsActivated = false;

// void selectStatus(String status) {
//   for (var situation in situations) {
//     situation['isChecked'] = situation['status'] == lastStatus;
//   }
// }

// void changeStatus(String statusCurrent) {
//   String status = '';
//   switch (statusCurrent.toLowerCase()) {
//     case 'em aberto':
//       status = 'Aprovado';
//     case 'aprovado':
//       status = 'Concluído';
//   }

//   selectStatus(status);
// }

// Future<String?> showDialogStatus(BuildContext context,
//     {required String status}) {
//   lastStatus = status;
//   selectStatus(status);
//   return showDialog<String>(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Column(
//             children: [
//               Column(
//                 children: situations.map((st) {
//                   bool isChecked = st['isChecked'];
//                   return Column(
//                     children: [
//                       ListTile(
//                         leading: Icon(
//                           isChecked ? Icons.check : null,
//                           color: Colors.deepPurple,
//                           size: 25,
//                         ),
//                         title: Text(
//                           st['status'],
//                           style: isChecked
//                               ? TextStyle(
//                                   color: Colors.deepPurple,
//                                   fontWeight:
//                                       textStyleSmallFontWeight.fontWeight,
//                                   fontSize: textStyleSmallFontWeight.fontSize)
//                               : textStyleSmallDefault,
//                         ),
//                       ),
//                       const Divider()
//                     ],
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 15),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                   foregroundColor: Colors.white,
//                   textStyle: textStyleSmallDefault),
//               onPressed: status.toLowerCase() != 'em aberto' ? () {} : null,
//               child: const Icon(
//                 Icons.keyboard_arrow_left,
//                 size: 30,
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                   foregroundColor: Colors.white,
//                   textStyle: textStyleSmallDefault),
//               onPressed: !nextKeyIsActivated
//                   ? () {
//                       nextKeyIsActivated = true;
//                     }
//                   : null,
//               child: const Icon(
//                 Icons.keyboard_arrow_right,
//                 size: 30,
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                   foregroundColor: Colors.white,
//                   textStyle: textStyleSmallDefault),
//               onPressed: () {},
//               child: const Icon(
//                 Icons.check,
//                 size: 30,
//               ),
//             ),
//           ],
//         );
//       });
// }

import 'package:flutter/material.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class ShowDialogStatus extends StatefulWidget {
  final String statusCurrent;
  final String statusSelected;
  const ShowDialogStatus({
    super.key,
    required this.statusCurrent,
    required this.statusSelected,
  });

  @override
  State<ShowDialogStatus> createState() => _ShowDialogStatusState();
}

class _ShowDialogStatusState extends State<ShowDialogStatus> {
  List<Map<String, dynamic>> situations = [
    {'index': 0, 'status': 'Em aberto', 'isChecked': false},
    {'index': 1, 'status': 'Aprovado', 'isChecked': false},
    {'index': 2, 'status': 'Concluído', 'isChecked': false},
  ];

  late int indexStatusCurrent;
  late String statusCurrent;
  late Map<String, dynamic> statusSelected;
  bool nextKeyIsActivated = false;

  int selectStatus(String status) {
    int index = 0;
    for (var situation in situations) {
      situation['isChecked'] = situation['status'] == status;
      if (situation['status'] == status) {
        index = situation['index'];
      }
    }
    statusSelected = {
      'index': index,
      'status': status,
      'isChecked': true,
    };
    setState(() {});

    return index;
  }

  void goToNextStatus(String statusCurrent) {
    String status = '';
    switch (statusCurrent.toLowerCase()) {
      case 'em aberto':
        status = 'Aprovado';
      case 'aprovado':
        status = 'Concluído';
    }

    selectStatus(status);
  }

  void returnToPreviousStatus(String statusCurrent) {
    String status = '';
    switch (statusCurrent.toLowerCase()) {
      case 'concluído':
        status = 'Aprovado';
      case 'aprovado':
        status = 'Em aberto';
    }

    selectStatus(status);
  }

  @override
  void initState() {
    super.initState();
    statusCurrent = widget.statusCurrent;
    indexStatusCurrent = selectStatus(widget.statusSelected);
    // nextKeyIsActivated = statusSelected['index'] > indexStatusCurrent;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Column(
            children: situations.map((st) {
              bool isChecked = st['isChecked'];
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      isChecked ? Icons.check : null,
                      color: Colors.deepPurple,
                      size: 25,
                    ),
                    title: Text(
                      st['status'],
                      style: isChecked
                          ? TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: textStyleSmallFontWeight.fontWeight,
                              fontSize: textStyleSmallFontWeight.fontSize,
                            )
                          : textStyleSmallDefault,
                    ),
                  ),
                  const Divider()
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              textStyle: textStyleSmallDefault),
          onPressed: statusSelected['status'].toLowerCase() != 'em aberto'
              ? () {
                  returnToPreviousStatus(statusSelected['status']);
                  setState(() {
                    nextKeyIsActivated = false;
                  });
                }
              : null,
          child: const Icon(
            Icons.keyboard_arrow_left,
            size: 30,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              textStyle: textStyleSmallDefault),
          onPressed: !nextKeyIsActivated
              ? () {
                  goToNextStatus(statusSelected['status']);

                  setState(() {
                    nextKeyIsActivated =
                        statusSelected['index'] > indexStatusCurrent;
                  });
                }
              : null,
          child: const Icon(
            Icons.keyboard_arrow_right,
            size: 30,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              textStyle: textStyleSmallDefault),
          onPressed: statusSelected['status'] != statusCurrent
              ? () {
                  Navigator.of(context).pop(statusSelected['status']);
                }
              : null,
          child: const Icon(
            Icons.check,
            size: 30,
          ),
        ),
      ],
    );
  }
}
