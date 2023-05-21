class ServiceModel {
  List<Services>? services;
  bool? success;
  String? message;

  ServiceModel({this.services, this.success, this.message});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['image'] = this.image;
    data['service_name'] = this.serviceName;
    data['attachment'] = this.attachment;
    data['service_type'] = this.serviceType;
    data['in_favourite'] = this.inFavourite;
    return data;
  }
}