import '../Constants/export.dart';

class MealType extends StatelessWidget {
  final Color color;
  final String type;
  const MealType({super.key, required this.color, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Text(
          type,
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }
}
