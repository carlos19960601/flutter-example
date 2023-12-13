String getRequestTitleFromUrl(String? url) {
  if (url == null || url.trim() == "") {
    return "untitled";
  }
  if (url.contains("://")) {
    String rem = url.split("://")[1];
    if (rem.trim() == "") {
      return "untitled";
    }
    return rem;
  }
  return url;
}
