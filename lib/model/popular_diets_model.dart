class PopularDiets {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool boxIsSelected;

  PopularDiets({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxIsSelected
  });

  factory PopularDiets.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'iconPath': String iconPath,
        'level': String level,
        'duration': String duration,
        'calorie': String calorie,
      } =>
        PopularDiets(
          name: name,
          iconPath: iconPath,
          level: level,
          duration: duration,
          calorie: calorie,
          boxIsSelected: true
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

  static List < PopularDiets > getPopularDiets() {
    List < PopularDiets > popularDiets = [];

    popularDiets.add(
      PopularDiets(
       name: 'Blueberry Pancake',
       iconPath: 'assets/icons/blueberry-pancake.svg',
       level: 'Medium',
       duration: '30mins',
       calorie: '230kCal',
       boxIsSelected: true,
      )
    );

    popularDiets.add(
      PopularDiets(
       name: 'Salmon Nigiri',
       iconPath: 'assets/icons/salmon-nigiri.svg',
       level: 'Easy',
       duration: '20mins',
       calorie: '120kCal',
       boxIsSelected: false,
      )
    );

    popularDiets.add(
      PopularDiets(
       name: 'Honey PanCake',
       iconPath: 'assets/icons/salmon-nigiri.svg',
       level: 'Easy',
       duration: '30mins',
       calorie: '150kCal',
       boxIsSelected: false,
      )
    );

    return popularDiets;
  }
}