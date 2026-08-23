// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:lottie/lottie.dart' as _lottie;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/animations
  $AssetsImagesAnimationsGen get animations =>
      const $AssetsImagesAnimationsGen();

  /// Directory path: assets/images/imgs
  $AssetsImagesImgsGen get imgs => const $AssetsImagesImgsGen();
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsImagesAnimationsGen {
  const $AssetsImagesAnimationsGen();

  /// File path: assets/images/animations/Loading.json
  LottieGenImage get loading =>
      const LottieGenImage('assets/images/animations/Loading.json');

  /// List of all assets
  List<LottieGenImage> get values => [loading];
}

class $AssetsImagesImgsGen {
  const $AssetsImagesImgsGen();

  /// File path: assets/images/imgs/Filter.svg
  SvgGenImage get filter => const SvgGenImage('assets/images/imgs/Filter.svg');

  /// File path: assets/images/imgs/Heart.svg
  SvgGenImage get heart => const SvgGenImage('assets/images/imgs/Heart.svg');

  /// File path: assets/images/imgs/account_icon.svg
  SvgGenImage get accountIcon =>
      const SvgGenImage('assets/images/imgs/account_icon.svg');

  /// File path: assets/images/imgs/app_logo.svg
  SvgGenImage get appLogo =>
      const SvgGenImage('assets/images/imgs/app_logo.svg');

  /// File path: assets/images/imgs/arrow.svg
  SvgGenImage get arrow => const SvgGenImage('assets/images/imgs/arrow.svg');

  /// File path: assets/images/imgs/arrow_right.svg
  SvgGenImage get arrowRight =>
      const SvgGenImage('assets/images/imgs/arrow_right.svg');

  /// File path: assets/images/imgs/bag.svg
  SvgGenImage get bag => const SvgGenImage('assets/images/imgs/bag.svg');

  /// File path: assets/images/imgs/cart_empty.svg
  SvgGenImage get cartEmpty =>
      const SvgGenImage('assets/images/imgs/cart_empty.svg');

  /// File path: assets/images/imgs/cart_icon.svg
  SvgGenImage get cartIcon =>
      const SvgGenImage('assets/images/imgs/cart_icon.svg');

  /// File path: assets/images/imgs/check_duotone.svg
  SvgGenImage get checkDuotone =>
      const SvgGenImage('assets/images/imgs/check_duotone.svg');

  /// File path: assets/images/imgs/empty_wishlist.svg
  SvgGenImage get emptyWishlist =>
      const SvgGenImage('assets/images/imgs/empty_wishlist.svg');

  /// File path: assets/images/imgs/home_icon.svg
  SvgGenImage get homeIcon =>
      const SvgGenImage('assets/images/imgs/home_icon.svg');

  /// File path: assets/images/imgs/language.svg
  SvgGenImage get language =>
      const SvgGenImage('assets/images/imgs/language.svg');

  /// File path: assets/images/imgs/line_saved.svg
  SvgGenImage get lineSaved =>
      const SvgGenImage('assets/images/imgs/line_saved.svg');

  /// File path: assets/images/imgs/logout.svg
  SvgGenImage get logout => const SvgGenImage('assets/images/imgs/logout.svg');

  /// File path: assets/images/imgs/minus.svg
  SvgGenImage get minus => const SvgGenImage('assets/images/imgs/minus.svg');

  /// File path: assets/images/imgs/plus.svg
  SvgGenImage get plus => const SvgGenImage('assets/images/imgs/plus.svg');

  /// File path: assets/images/imgs/red_heart.svg
  SvgGenImage get redHeart =>
      const SvgGenImage('assets/images/imgs/red_heart.svg');

  /// File path: assets/images/imgs/saved_icon.svg
  SvgGenImage get savedIcon =>
      const SvgGenImage('assets/images/imgs/saved_icon.svg');

  /// File path: assets/images/imgs/search_icon.svg
  SvgGenImage get searchIcon =>
      const SvgGenImage('assets/images/imgs/search_icon.svg');

  /// File path: assets/images/imgs/star_gold.svg
  SvgGenImage get starGold =>
      const SvgGenImage('assets/images/imgs/star_gold.svg');

  /// File path: assets/images/imgs/star_grey.svg
  SvgGenImage get starGrey =>
      const SvgGenImage('assets/images/imgs/star_grey.svg');

  /// File path: assets/images/imgs/trash.svg
  SvgGenImage get trash => const SvgGenImage('assets/images/imgs/trash.svg');

  /// File path: assets/images/imgs/warning.svg
  SvgGenImage get warning =>
      const SvgGenImage('assets/images/imgs/warning.svg');

  /// File path: assets/images/imgs/waves.svg
  SvgGenImage get waves => const SvgGenImage('assets/images/imgs/waves.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    filter,
    heart,
    accountIcon,
    appLogo,
    arrow,
    arrowRight,
    bag,
    cartEmpty,
    cartIcon,
    checkDuotone,
    emptyWishlist,
    homeIcon,
    language,
    lineSaved,
    logout,
    minus,
    plus,
    redHeart,
    savedIcon,
    searchIcon,
    starGold,
    starGrey,
    trash,
    warning,
    waves,
  ];
}

abstract final class Assets {
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName, {this.flavors = const {}});

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, _lottie.LottieComposition?)?
    frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
