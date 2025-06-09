// lib/data/services/content_generator.dart
class CatContentGenerator {
  static List<Map<String, dynamic>> generateFeeds() {
    return [
      {
        'title': 'Cats Feeding tips',
        'description': 'Choose high-quality cat food with real meat listed as the first ingredient. Look for complete nutrition with taurine for eye and heart health.',
        'type': 'feeding',
        'imageUrl': 'assets/images/diy_feeder.png',
        'likes': 0,
      },
//      {
 //       'title': 'Smart Auto-Feeder Review',
  //      'description': 'Tech meets pet care: This WiFi-enabled feeder lets you schedule meals and monitor portions via your phone.',
  //      'type': 'TECH',
   //     'imageUrl': 'assets/images/smart_feeder.png',
   //     'likes': 189,
  //    },
   //   {
   //     'title': 'Multi-Cat Feeding Tips',
   //     'description': 'Create peace at mealtime! Learn how to set up separate feeding zones for multiple cats.',
    //    'type': 'TIPS',
    //    'imageUrl': 'assets/images/feeding_tips.png',
    //    'likes': 312,
   //   },
   //   {
    //    'title': 'Eco-Friendly Bamboo Feeders',
    //    'description': 'Sustainable and stylish: These raised bamboo bowls are perfect for your eco-conscious feline friend.',
     //  'type': 'ECO',
      //  'imageUrl': 'assets/images/bamboo_feeder.png',
     //   'likes': 167,
   //   }
    ];
  }
}

// Update HomeScreen to use this content
