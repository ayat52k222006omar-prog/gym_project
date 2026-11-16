class ExerciseModel {
  final String id;
  final String name;
  bool isExpanded;

  double barbellWeight;
  double machineWeight;
  double dumbbellWeight;
  double barbellStep;

  ExerciseModel({
    required this.id,
    required this.name,
    this.isExpanded = false,
    this.barbellWeight = 60.0,
    this.machineWeight = 40.0,
    this.dumbbellWeight = 5.0,
    this.barbellStep = 2.5,
  });

  double getWeight(String category) {
    switch (category) {
      case 'Barbell':
        return barbellWeight;
      case 'Machine':
        return machineWeight;
      case 'Dumbbell':
        return dumbbellWeight;
      default:
        return 0.0;
    }
  }

  // 🌟 نقلنا منطق تعديل الأوزان والدمبل والماشين هنا جوه الموديل نفسه!
  void updateWeight(String category, bool isAdd) {
    if (category == 'Barbell') {
      double step = barbellStep;
      if (isAdd) {
        barbellWeight += step;
      } else {
        if (barbellWeight >= step) barbellWeight -= step;
      }
    } 
    else if (category == 'Machine') {
      double step = 5.0;
      if (isAdd) {
        machineWeight += step;
      } else {
        if (machineWeight >= step) machineWeight -= step;
      }
    } 
    else if (category == 'Dumbbell') {
      if (isAdd) {
        if (dumbbellWeight < 5.0) {
          dumbbellWeight += 1.0;
        } else {
          dumbbellWeight += 2.5;
        }
      } else {
        if (dumbbellWeight <= 5.0) {
          if (dumbbellWeight > 1.0) dumbbellWeight -= 1.0;
        } else {
          dumbbellWeight -= 2.5;
        }
      }
    }
  }
}