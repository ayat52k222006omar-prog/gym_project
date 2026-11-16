import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_application/gym/core/models/exercise_model.dart';

class WeightsScreen extends StatefulWidget {
  const WeightsScreen({Key? key}) : super(key: key);

  @override
  State<WeightsScreen> createState() => _WeightsScreenState();
}

class _WeightsScreenState extends State<WeightsScreen> {
  String _globalSelectedCategory = 'Barbell';

  // 🌟 قائمة التمارين فقط لا غير (بناءً على طلبك)
  final List<ExerciseModel> _exercises = [
    ExerciseModel(
        id: '1',
        name: 'Barbell Bench Press',
        barbellWeight: 60.0,
        machineWeight: 50.0,
        dumbbellWeight: 25.0),
    ExerciseModel(
        id: '2',
        name: 'Incline Barbell Press',
        barbellWeight: 50.0,
        machineWeight: 40.0,
        dumbbellWeight: 22.0),
    ExerciseModel(
        id: '3',
        name: 'Decline Barbell Press',
        barbellWeight: 55.0,
        machineWeight: 45.0,
        dumbbellWeight: 22.5),
    ExerciseModel(
        id: '4',
        name: 'Incline Dumbbell Press',
        barbellWeight: 40.0,
        machineWeight: 35.0,
        dumbbellWeight: 18.0),
    ExerciseModel(
        id: '5',
        name: 'Flat Dumbbell Press',
        barbellWeight: 45.0,
        machineWeight: 35.0,
        dumbbellWeight: 20.0),
    ExerciseModel(
        id: '6',
        name: 'Chest Fly (Pec Deck)',
        barbellWeight: 30.0,
        machineWeight: 35.0,
        dumbbellWeight: 12.5),
    ExerciseModel(
        id: '7',
        name: 'Incline Dumbbell Fly',
        barbellWeight: 25.0,
        machineWeight: 30.0,
        dumbbellWeight: 10.0),
    ExerciseModel(
        id: '8',
        name: 'Cable Crossover',
        barbellWeight: 20.0,
        machineWeight: 25.0,
        dumbbellWeight: 10.0),
    ExerciseModel(
        id: '9',
        name: 'Low Cable Fly',
        barbellWeight: 17.5,
        machineWeight: 20.0,
        dumbbellWeight: 7.5),
    ExerciseModel(
        id: '10',
        name: 'Weighted Dips',
        barbellWeight: 10.0,
        machineWeight: 15.0,
        dumbbellWeight: 5.0),
    ExerciseModel(
        id: '11',
        name: 'Machine Chest Press',
        barbellWeight: 50.0,
        machineWeight: 60.0,
        dumbbellWeight: 25.0),
    ExerciseModel(
        id: '12',
        name: 'Push-ups (Bodyweight)',
        barbellWeight: 0.0,
        machineWeight: 0.0,
        dumbbellWeight: 0.0),
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryTurquoise = Color(0xFF5DBB9E);
    const Color darkText = Color(0xFF0F3036);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 152, 238, 224),
              Color.fromRGBO(182, 239, 228, 1),
              Color.fromARGB(255, 209, 238, 231),
            ],
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Row(mainAxisAlignment :MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding:EdgeInsets.only(left: 30),
                   // padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Weights',
                      style:
                          TextStyle(color: darkText, fontWeight: FontWeight.bold ,fontSize: 24),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: darkText, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // شريط الكاتيجوري الرئيسي فوق
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['Barbell', 'Machine', 'Dumbbell'].map((category) {
                  bool isSelected = _globalSelectedCategory == category;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _globalSelectedCategory = category;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryTurquoise : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            if (!isSelected)
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : darkText,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // قائمة التمارين مع السكرول
            Expanded(
              child: ListView.builder(
                itemCount: _exercises.length,
                padding: const EdgeInsets.only(bottom: 30),
                itemBuilder: (context, index) {
                  final exercise = _exercises[index];
                  return _buildExerciseCard(exercise);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تصميم الكارد
  Widget _buildExerciseCard(ExerciseModel exercise) {
    const Color primaryTurquoise = Color(0xFF5DBB9E);
    const Color darkText = Color(0xFF0F3036);

    double currentWeight = exercise.getWeight(_globalSelectedCategory);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الكارد المقفول
          GestureDetector(
            onTap: () {
              setState(() {
                exercise.isExpanded = !exercise.isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$currentWeight kg',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    exercise.isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: primaryTurquoise,
                  ),
                  onPressed: () {
                    setState(() {
                      exercise.isExpanded = !exercise.isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),

          // الكارد المفتوح (Expanded)
          if (exercise.isExpanded) ...[
            const Divider(height: 24),

            // تحكم الوزن (- و +) باستخدام الدالة الموجودة داخل الموديل مباشرة
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      exercise.updateWeight(_globalSelectedCategory, false);
                    });
                  },
                  icon: const Icon(Icons.remove_circle_outline,
                      size: 32, color: Colors.redAccent),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '$currentWeight kg',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkText),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      exercise.updateWeight(_globalSelectedCategory, true);
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline,
                      size: 32, color: primaryTurquoise),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // أزرار اختيار طارات البار (تظهر حصرياً للـ Barbell فقط)
            if (_globalSelectedCategory == 'Barbell') ...[
              const Center(
                child: Text(
                  'Select Plate Step:',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1.25, 2.5, 5.0].map((stepValue) {
                  bool isStepSelected = exercise.barbellStep == stepValue;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text('+$stepValue kg'),
                      selected: isStepSelected,
                      selectedColor: primaryTurquoise.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isStepSelected ? primaryTurquoise : darkText,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          exercise.barbellStep = stepValue;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],

            // زرار Save Weight
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    exercise.isExpanded = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Saved ${exercise.name} ($_globalSelectedCategory) -> $currentWeight kg'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: primaryTurquoise,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryTurquoise,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text(
                  'Save Weight',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}