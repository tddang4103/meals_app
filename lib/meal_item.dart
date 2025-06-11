import 'package:flutter/material.dart';
import 'package:meals_app/meal_item_trait.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectedMeal});

  final Meal meal;
  final void Function() onSelectedMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: onSelectedMeal,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title, // 1. Dữ liệu hiển thị
                      maxLines: 2, // 2. Số dòng tối đa
                      textAlign: TextAlign.center, // 3. Căn chỉnh văn bản
                      softWrap: true, // 4. Tự động xuống dòng
                      overflow: TextOverflow.ellipsis, // 5. Xử lý tràn văn bản
                      style: const TextStyle(
                        // 6. Kiểu chữ
                        fontSize: 20, // 6a. Kích thước font
                        fontWeight: FontWeight.bold, // 6b. Độ đậm của chữ
                        color: Colors.white, // 6c. Màu chữ
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 20),
                        MealItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(width: 20),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
