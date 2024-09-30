import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key, required this.Title, required this.Count,

  });
  final String Title;
  final int Count;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: SizedBox(
        width: 100,
        child: Padding(padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$Count",style: TextStyle(fontSize:16,fontWeight: FontWeight.w700),),
              Text(Title,style: TextStyle(fontSize:16,color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
