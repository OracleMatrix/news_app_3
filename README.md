# News App 3 Update

A Flutter-based news application that fetches and displays news articles, supports image caching, and allows users to share and download content.

## Features

- **News Fetching**: Fetches news articles from various sources.
- **Image Caching**: Uses `cached_network_image` to cache images for faster loading.
- **Sharing**: Allows users to share news articles via `share_plus`.
- **Downloading**: Supports downloading content using `flutter_downloader`.
- **Photo Viewing**: Provides a detailed view of images with `photo_view`.
- **Custom Icons**: Generates custom launcher icons using `flutter_launcher_icons`.

## Dependencies

This project uses the following key dependencies:

- **Flutter**: The core framework for building the app.
- **Get**: For state management and navigation.
- **Cached Network Image**: For caching and displaying network images.
- **URL Launcher**: For launching URLs in the browser.
- **Share Plus**: For sharing content.
- **Flutter Launcher Icons**: For generating custom app icons.
- **Photo View**: For zoomable images.
- **Flutter Downloader**: For downloading files.
- **Path Provider**: For accessing device file paths.

For a complete list of dependencies, see the [pubspec.yaml](pubspec.yaml) file.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/news_app_3_update.git
   ```
2. **Navigate to the project directory**:
   ```bash
   cd news_app_3_update
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## flutter run

**Environment**
- Flutter SDK: `^3.24.5`

- Dart SDK: `^3.5.4`

## Support
If you find this project useful, please consider giving it a ⭐️ on `GitHub`. Your support is greatly appreciated!

## Assets
- Images: Place your images in the `assets/images/` directory.

- Icons: Use `flutter_launcher_icons` to generate custom app icons.

## Fonts

To add custom fonts, update the `fonts` section in the `pubspec.yaml` file.

## Contributing
Contributions are welcome! Please follow these steps:

1. Fork the repository.

2. Create a new branch `(git checkout -b feature/YourFeatureName)`.

3. Commit your changes `(git commit -m 'Add some feature')`.

4. Push to the branch `(git push origin feature/YourFeatureName)`.

5. Open a pull request.

## License
This project is licensed under the MIT `License`. See the LICENSE file for details.

## Acknowledgments

- Flutter: For providing an amazing framework.

- Pub.dev: For hosting the packages used in this project.

- All Contributors: For their valuable contributions.