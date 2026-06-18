class TransactionCategorizer {
  static const Map<String, String> _merchantCategories = {
    // Food
    'swiggy': 'Food',
    'zomato': 'Food',
    'dominos': 'Food',
    'pizza hut': 'Food',
    'mcdonald': 'Food',
    'kfc': 'Food',
    'burger king': 'Food',

    // Travel
    'uber': 'Travel',
    'ola': 'Travel',
    'rapido': 'Travel',

    // Shopping
    'amazon': 'Shopping',
    'flipkart': 'Shopping',
    'myntra': 'Shopping',
    'ajio': 'Shopping',
    'meesho': 'Shopping',
    'nykaa': 'Shopping',

    // Bills
    'electricity': 'Bills',
    'water': 'Bills',
    'gas': 'Bills',
    'airtel': 'Bills',
    'jio': 'Bills',
    'vi': 'Bills',
    'bsnl': 'Bills',

    //Entertainment
    'netflix': 'Entertainment',
    'prime video': 'Entertainment',
    'hotstar': 'Entertainment',
    'spotify': 'Entertainment',

    // Health
    'apollo': 'Health',
    '1mg': 'Health',
    'pharmeasy': 'Health',
   
  };

  static const Map<String, List<String>> _categoryKeywords = {
    'Food': [
      'restaurant',
      'cafe',
      'dhaba',
      'bakery',
      'food',
      'eatery',
      'canteen',
    ],

    'Travel': [
      'petrol',
      'fuel',
      'diesel',
      'travel',
      'taxi',
      'cab',
      'bus',
      'metro',
    ],

    'Bills': [
      'electricity',
      'water',
      'gas',
      'recharge',
      'broadband',
      'wifi',
      'mobile',
      'bill',
    ],

    'Shopping': [
      'store',
      'mart',
      'market',
      'shopping',
      'fashion',
      'clothing',
    ],

    'Entertainment': [
      'movie',
      'cinema',
      'theatre',
      'concert',
      'music',
      'game',
    ],

    'Health': [
      'hospital',
      'clinic',
      'pharmacy',
      'doctor',
      'medicine',
      'healthcare',
    ],
  };

  static String categorize(
    String merchant,
  ) {
    final normalizedMerchant =
        merchant.toLowerCase();

    // Merchant-based categorization

    for (final entry
        in _merchantCategories.entries) {
      if (normalizedMerchant.contains(
        entry.key,
      )) {
        return entry.value;
      }
    }
    // Keyword-based categorization

    for (final categoryEntry
        in _categoryKeywords.entries) {
      for (final keyword
          in categoryEntry.value) {
        if (normalizedMerchant.contains(
          keyword,
        )) {
          return categoryEntry.key;
        }
      }
    }
    
    return 'Other';
  }
}