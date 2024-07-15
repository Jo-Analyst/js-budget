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
  Map<String, dynamic> statusSelected = {};
  bool nextKeyIsActivated = false;

  void selectStatus(String status) {
    for (var situation in situations) {
      situation['isChecked'] = situation['status'] == status;

      statusSelected =
          situation['status'] == status ? situation : statusSelected;
    }

    setState(() {});
  }

  int getIndexStatusCurrent(String status) {
    int index = 0;
    for (var situation in situations) {
      if (situation['status'] == statusCurrent) {
        index = situation['index'];
      }
    }

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
    indexStatusCurrent = getIndexStatusCurrent(statusCurrent);
    selectStatus(widget.statusSelected);
    nextKeyIsActivated = statusSelected['index'] > indexStatusCurrent;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: 'Status atual: ',
              style: textStyleMediumFontWeight,
            ),
            TextSpan(
              text: widget.statusCurrent,
              style: textStyleMediumDefault,
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
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
                              fontWeight: textStyleMediumFontWeight.fontWeight,
                              fontSize: textStyleMediumFontWeight.fontSize,
                            )
                          : textStyleMediumDefault,
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
              textStyle: textStyleMediumDefault),
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
            textStyle: textStyleMediumDefault,
          ),
          onPressed: !nextKeyIsActivated &&
                  statusSelected['status'].toLowerCase() != 'concluído'
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
              textStyle: textStyleMediumDefault),
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
