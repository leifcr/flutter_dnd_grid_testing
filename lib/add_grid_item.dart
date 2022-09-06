import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testgrid/grid_controller.dart';
import 'package:testgrid/grid_item.dart';
import 'package:testgrid/grid_position.dart';

class AddGridItem extends StatefulWidget {
  const AddGridItem({Key? key}) : super(key: key);

  @override
  AddGridItemState createState() => AddGridItemState();
}

class AddGridItemState extends State<AddGridItem> {
  int x = 0;
  int y = 0;
  int w = 1;
  int h = 1;
  GridController? controller;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<GridController>(context, listen: false);
    return Row(children: [
      Expanded(child: Container()),
      Expanded(
          child: Form(
              key: _formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(height: 10),
                Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "X"),
                        initialValue: "0",
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          if (value.isEmpty) {
                            x = 0;
                          } else {
                            x = int.parse(value);
                          }
                        }
                        // Only numbers can be entered
                        )),
                const SizedBox(height: 10),
                Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Y"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        initialValue: "0",
                        onChanged: (value) {
                          if (value.isEmpty) {
                            y = 0;
                          } else {
                            y = int.parse(value);
                          }
                        }
                        // Only numbers can be entered
                        )),
                const SizedBox(height: 10),
                Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Width"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        initialValue: "1",
                        onChanged: (value) {
                          if (value.isEmpty) {
                            w = 1;
                          } else {
                            w = int.parse(value);
                          }
                        }
                        // Only numbers can be entered
                        )),
                const SizedBox(height: 10),
                Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Height"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        initialValue: "1",
                        onChanged: (value) {
                          if (value.isEmpty) {
                            h = 1;
                          } else {
                            h = int.parse(value);
                          }
                        }
                        // Only numbers can be entered
                        )),
                const SizedBox(height: 10),
                MaterialButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    controller?.add(GridItem(position: GridPosition(x, y, w, h), key: UniqueKey()));
                  },
                  child: const Text('Add item, with data below'),
                )
              ]))),
      Expanded(child: Container()),
    ]);
  }
}
