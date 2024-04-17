class ServiceModel {
  List<Services>? services;
  bool? success;
  String? message;

  ServiceModel({this.services, this.success, this.message});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class Services {
  String? fullname;
  String? image;
  String? serviceName;
  String? attachment;
  int? serviceType;
  int? inFavourite;

  Services(
      {this.fullname,
        this.image,
        this.serviceName,
        this.attachment,
        this.serviceType,
        this.inFavourite});

  Services.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    image = json['image'];
    serviceName = json['service_name'];
    attachment = json['attachment'];
    serviceType = json['service_type'];
    inFavourite = json['in_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['image'] = image;
    data['service_name'] = serviceName;
    data['attachment'] = attachment;
    data['service_type'] = serviceType;
    data['in_favourite'] = inFavourite;
    return data;
  }
}