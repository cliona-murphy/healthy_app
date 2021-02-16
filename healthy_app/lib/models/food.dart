class Food {
  final String name;
  final int calories;
  final String mealId;

  Food({this.name, this.calories, this.mealId});

  printFoodInfo(){
    print("Food name is: " + name);
  }
  getName(){
    return name;
  }

  getCalories(){
    return calories;
  }

  getMealId(){
    return mealId;
  }
}