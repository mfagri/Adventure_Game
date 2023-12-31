class AdmobData {
  final List<String> bannerIds;
  final List<String> interIds;
  final List<String> nativeIds;
  final List<String> rewardIds;
  final String openAdsId;

  AdmobData.fromJson(Map<String, dynamic> json)
      : bannerIds = List<String>.from(json['bannerIds'] ?? []),
        interIds = List<String>.from(json['interIds'] ?? []),
        nativeIds = List<String>.from(json['nativeIds'] ?? []),
        rewardIds = List<String>.from(json['rewardIds'] ?? []),
        openAdsId = json['openAdsIds'] ?? "";
}
