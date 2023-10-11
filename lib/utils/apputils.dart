class AppUtils{
  static String? getUsername(String userId) {
    switch (userId) {
      case '1':
        return 'Leanne Graham';
      case '2':
        return 'Ervin Howell';
      case '3':
        return 'Clementine Bauch';
      case '4':
        return 'Patricia Lebsack';
      case '5':
        return 'Chelsey Dietrich';
      case '6':
        return 'Mrs. Dennis Schulist';
      case '7':
        return 'Kurtis Weissnat';
      case '8':
        return 'Nicholas Runolfsdottir V';
      case '9':
        return 'Glenna Reichert';
      case '10':
        return 'Clementina DuBuque';
      default:
        return null; // Return null for cases not found in the switch statement.
    }
  }
}