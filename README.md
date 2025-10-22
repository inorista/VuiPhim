# 🎬 VuiPhim - Ứng dụng xem phim hiện đại

<p align="center">
  <img src="assets/images/vuiphim_logo_transparent.png" alt="VuiPhim Logo" width="200"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%5E3.8.0-blue.svg" alt="Flutter Version">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-brightgreen.svg" alt="Platform">
</p>

**VuiPhim** là một ứng dụng xem phim hiện đại được xây dựng bằng Flutter, mang đến trải nghiệm xem phim mượt mà và trực quan trên thiết bị di động. Ứng dụng cung cấp thư viện phim phong phú với giao diện người dùng đẹp mắt và các tính năng tiên tiến.

## 🌟 Tính năng nổi bật

### 🎭 Giao diện người dùng hiện đại
- **Thiết kế Material Design** tinh tế với dark theme
- **Hiệu ứng chuyển động mượt mà** sử dụng Flutter Animation
- **Responsive layout** phù hợp với mọi kích thước màn hình

### 🎥 Trải nghiệm xem phim cao cấp
- **Trình phát video tùy chỉnh** với điều khiển đầy đủ
- **Slider điều chỉnh âm lượng dọc** giống Netflix
- **Hiệu ứng blur background** khi xem phim
- **Tự động lưu vị trí xem** phim

### 🎯 Chức năng chính
- **Khám phá phim** theo danh mục: Phim hot, Phim đề cử, Phim sắp ra mắt
- **Tìm kiếm phim** nhanh chóng với gợi ý thông minh
- **Chi tiết phim** với thông tin đầy đủ: Diễn viên, đạo diễn, thể loại
- **Xem phim theo tập** cho phim bộ với danh sách tập phim
- **Điều chỉnh độ sáng màn hình** trực tiếp trong trình phát

### 🔧 Công nghệ sử dụng
- **Flutter Framework** với Dart language
- **Bloc Pattern** để quản lý state
- **Go Router** cho điều hướng giữa các màn hình
- **Hive Database** lưu trữ dữ liệu local
- **Firebase** cho authentication và data services
- **Video Player** cho trải nghiệm xem phim mượt mà
- **Custom Paint** để tạo hiệu ứng UI độc đáo

## 📱 Hình ảnh minh họa

<div align="center">
  <table>
    <tr>
      <td><img src="screenshots/home_screen.png" alt="Home Screen" width="200"/></td>
      <td><img src="screenshots/movie_detail.png" alt="Movie Detail" width="200"/></td>
      <td><img src="screenshots/video_player.png" alt="Video Player" width="200"/></td>
      <td><img src="screenshots/explore.png" alt="Explore" width="200"/></td>
    </tr>
    <tr>
      <td align="center">Màn hình chính</td>
      <td align="center">Chi tiết phim</td>
      <td align="center">Trình phát video</td>
      <td align="center">Khám phá</td>
    </tr>
  </table>
</div>

## 🚀 Bắt đầu

### Yêu cầu
- Flutter SDK >= 3.8.0
- Dart SDK >= 3.0.0
- Android Studio / Xcode

### Cài đặt

```bash
# Clone repository
git clone https://github.com/Inorista/vuiphim.git
cd vuiphim

# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng
flutter run
```

### Chạy tests

Để chạy các bài test có trong dự án:

```bash
flutter test
```

### Cấu hình Firebase
1. Tạo project Firebase mới
2. Thêm file `google-services.json` vào `android/app/`
3. Thêm file `GoogleService-Info.plist` vào `ios/Runner/`

## 🏗️ Kiến trúc

Ứng dụng sử dụng kiến trúc phân lớp rõ ràng:

```
lib/
├── core/                 # Core utilities và services
│   ├── di/              # Dependency injection
│   ├── router/          # App routing
│   ├── services/        # Services
│   └── utils/           # Utilities
├── data/                # Data layer
│   ├── dtos/            # Data Transfer Objects
│   ├── hive_database/   # Local database
│   └── repositories/    # Data repositories
├── presentation/        # Presentation layer
│   ├── blocs/           # Business Logic Components
│   ├── screens/         # UI Screens
│   └── utils/           # Custom widgets
└── main.dart            # Entry point
```

## 🎨 Widgets tùy chỉnh

### Vertical Slider
Slider dọc tùy chỉnh giống Netflix với hiệu ứng glow và gradient:

```dart
VerticalSlider(
  value: _volume,
  onChanged: (value) => setState(() => _volume = value),
  activeColor: Colors.red,
  thumbColor: Colors.white,
)
```

### Smooth Progress Indicator
Thanh tiến trình video mượt mà với animation:

```dart
SmoothVideoProgressSlider(
  value: _progress,
  onChanged: _onProgressChanged,
)
```

## 🔐 Bảo mật

- **Secure Storage** lưu trữ token và thông tin nhạy cảm
- **HTTPS** cho tất cả API calls
- **Input validation** tại cả client và server side

## 📊 Performance

- **Lazy loading** cho danh sách phim
- **Cache hình ảnh** với CachedNetworkImage
- **Shimmer loading** cho trải nghiệm chờ
- **Optimized rebuilds** với Bloc buildWhen

## 🤝 Đóng góp

1. Fork repository
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

## 📄 License

Distributed under the MIT License. Xem `LICENSE` để biết thêm thông tin.

## 👨‍💻 Tác giả

**Inorista** - [ngotu2102@gmail.com](mailto:ngotu2102@gmail.com)

## 🙏 Lời cảm ơn

- Cảm ơn [TMDB](https://www.themoviedb.org/) đã cung cấp API phim
- Cảm ơn cộng đồng Flutter đã tạo ra những thư viện tuyệt vời

---

<p align="center">
  Made with ❤️ using Flutter
</p>