class AppConstants {
  // Map Settings
  static const mapDefaultZoom = 13.0;
  static const mapMaxZoom = 18.0;
  static const mapMinZoom = 3.0;
  
  // Asset URLs
  static const defaultAvatarUrl = 'assets/images/default_avatar.png';
  static const catPlaceholderUrl = 'assets/images/cat_placeholder.png';
  static const pawIconUrl = 'assets/icons/paw.svg';
  
  // Supabase Storage
  static const supabaseImageBucket = 'cat_images';
  
  // API Endpoints
  static const apiVersion = 'v1';
  static const baseApiUrl = 'https://api.nekofind.com/$apiVersion';
  
  // Cache Settings
  static const imageCacheDuration = Duration(days: 7);
  static const maxCacheSize = 200 * 1024 * 1024; // 200MB
  
  // Validation
  static const maxImageSize = 5 * 1024 * 1024; // 5MB
  static const maxImagesPerPost = 5;
  static const minTitleLength = 5;
  static const maxTitleLength = 100;
  static const maxDescriptionLength = 500;
}