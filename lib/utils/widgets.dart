import 'package:flutter/material.dart';

List<Color> colors = [
  const Color(0xFFFFFFFF),
  const Color(0xffF28B83),
  const Color(0xFFFCBC05),
  const Color(0xFFFFF476),
  const Color(0xFFCBFF90),
  const Color(0xFFA7FEEA),
  const Color(0xFFE6C9A9),
  const Color(0xFFE8EAEE),
  const Color(0xFFA7FEEA),
  const Color(0xFFCAF0F8)
];

class PriorityPicker extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;
  const PriorityPicker({Key key, this.onTap, this.selectedIndex}) : super(key: key);
  @override
  _PriorityPickerState createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  int selectedIndex;
  List<String> priorityText = ['Low', 'High', 'Very High'];
  List<Color> priorityColor = [Colors.green, Colors.lightGreen, Colors.red];
  @override
  Widget build(BuildContext context) {
    selectedIndex ??= widget.selectedIndex;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: width / 3,
              height: 70,
              child: Container(
                child: Center(
                  child: Text(priorityText[index],
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? priorityColor[index]
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    border: selectedIndex == index
                        ? Border.all(width: 2, color: Colors.black)
                        : Border.all(width: 0,color: Colors.transparent)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;
  const ColorPicker({Key key, this.onTap, this.selectedIndex}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    selectedIndex ??= widget.selectedIndex;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 50,
              height: 50,
              child: Container(
                child: Center(
                    child: selectedIndex == index
                        ? const Icon(Icons.done)
                        : Container()),
                decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }
}
