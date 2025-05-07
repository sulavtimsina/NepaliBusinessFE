class Business {
  final String name;
  final String imageUrl;
  final String category;
  final double rating;
  final String location;
  final String description;
  final String ownerName;
  final String contactNumber;
  final String emailAddress;
  final String websiteUrl;
  final String facebook;
  final String instagram;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String languageSpoken;
  final String operatingHours;
  final String paymentMethods;
  final String specialOffers;
  final String verificationStatus;

  Business({
    required this.name,
    this.imageUrl = '',
    this.category = '',
    this.rating = 0.0,
    this.location = '',
    this.description = '',
    this.ownerName = '',
    this.contactNumber = '',
    this.emailAddress = '',
    this.websiteUrl = '',
    this.facebook = '',
    this.instagram = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.country = '',
    this.languageSpoken = '',
    this.operatingHours = '',
    this.paymentMethods = '',
    this.specialOffers = '',
    this.verificationStatus = '',
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['Name'] ?? '',
      imageUrl: json['ImageUrl'] ?? '',
      category: json['Category'] ?? '',
    rating: double.tryParse(json['Rating'].toString()) ?? 0.0,
      location: json['Location'] ?? '',
      description: json['Description'] ?? '',
      ownerName: json['OwnerName'] ?? '',
      contactNumber: json['ContactNumber'] ?? '',
      emailAddress: json['EmailAddress'] ?? '',
      websiteUrl: json['WebsiteURL'] ?? '',
      facebook: json['Facebook'] ?? '',
      instagram: json['Instagram'] ?? '',
      city: json['City'] ?? '',
      state: json['StateRegion'] ?? '',
      zipCode: json['Zipcode'] ?? '',
      country: json['Country'] ?? '',
      languageSpoken: json['LanguageSpoken'] ?? '',
      operatingHours: json['OperatingHours'] ?? '',
      paymentMethods: json['PaymentMethods'] ?? '',
      specialOffers: json['SpecialOffers'] ?? '',
      verificationStatus: json['VerificationStatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ImageUrl': imageUrl,
      'Category': category,
      'Rating': rating,
      'Location': location,
      'Description': description,
      'OwnerName': ownerName,
      'ContactNumber': contactNumber,
      'EmailAddress': emailAddress,
      'WebsiteURL': websiteUrl,
      'Facebook': facebook,
      'Instagram': instagram,
      'City': city,
      'StateRegion': state,
      'Zipcode': zipCode,
      'Country': country,
      'LanguageSpoken': languageSpoken,
      'OperatingHours': operatingHours,
      'PaymentMethods': paymentMethods,
      'SpecialOffers': specialOffers,
      'VerificationStatus': verificationStatus,
    };
  }
}