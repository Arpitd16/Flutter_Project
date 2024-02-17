import 'package:flutter/material.dart';

enum Priority { urgent, normal, low }


class Checkableitem extends StatefulWidget{
  const Checkableitem(this.text, this.priority, {super.key});

  final String text;
  final Priority priority;

  @override
  State<Checkableitem> createState() => _Checkableitem();
}

class _Checkableitem extends State<Checkableitem>{
  var _checked = false;

  void setchecked(bool? ischecked){
    setState(() {
      _checked=ischecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.low_priority;

    if (widget.priority == Priority.urgent) {
      icon = Icons.notifications_active;
    }
    if (widget.priority == Priority.normal) {
      icon = Icons.list;
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Checkbox(value: _checked, onChanged: setchecked,),
          const SizedBox(width: 6),
          Icon(icon),
          const SizedBox(width: 12),
          Text(widget.text),
        ],
      ),
    );
  }
}