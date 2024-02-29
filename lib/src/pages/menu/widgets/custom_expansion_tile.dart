import 'package:flutter/material.dart';

import 'package:js_budget/src/themes/light_theme.dart';

class CustomExpansionTileWidget extends StatefulWidget {
  final String title;
  final Icon? icon;
  final List<Widget>? children;
  final bool initiallyExpanded;
  const CustomExpansionTileWidget({
    Key? key,
    required this.title,
    this.icon,
    this.children,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<CustomExpansionTileWidget> createState() =>
      _CustomExpansionTileWidgetState();
}

class _CustomExpansionTileWidgetState extends State<CustomExpansionTileWidget>
    with TickerProviderStateMixin {
  late bool isExpanded;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: .5,
          ),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
                if (isExpanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: ListTile(
              leading: widget.icon,
              title: Text(
                widget.title,
                style: TextStyle(
                    fontFamily: textStyleSmallDefault.fontFamily,
                    fontSize: textStyleSmallDefault.fontSize,
                    fontWeight: FontWeight.w600),
              ),
              trailing: RotationTransition(
                turns: Tween(begin: 0.0, end: 0.50).animate(_controller),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: const Color.fromARGB(255, 242, 240, 240),
              child: isExpanded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.children != null
                          ? widget.children!
                              .map((e) => Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: isExpanded &&
                                                widget.children!.isNotEmpty
                                            ? BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: .5,
                                                  ),
                                                ),
                                              )
                                            : null,
                                        child: e,
                                      ),
                                    ],
                                  ))
                              .toList()
                          : [],
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}
