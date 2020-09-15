class ImagePic{
  String filename;
  String fileDownloadUri;
  String fileType;
  int size;

  ImagePic({
    this.filename,
    this.fileDownloadUri,
    this.fileType,
    this.size
  });

factory ImagePic.fromjson(Map<String, dynamic> json) {
    return ImagePic(
      filename: json['filename'],
      fileDownloadUri: json['filedownloda_url'],
      fileType: json['filetype'],
      size: json['size'],
     
    );
  }

  static fromjson2(json) {}
}