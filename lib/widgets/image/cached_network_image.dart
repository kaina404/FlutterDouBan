library cached_network_image;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show instantiateImageCodec, Codec;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// CachedNetworkImage for Flutter
///
/// Copyright (c) 2017 Rene Floor
///
/// Released under MIT License.
///缓存网络图片
class CachedNetworkImage extends StatefulWidget {
  static List<Object> _registeredErrors = <Object>[];

  /// Creates a widget that displays a [placeholder] while an [imageUrl] is loading
  /// then cross-fades to display the [imageUrl].
  /// Optional [httpHeaders] can be used for example for authentication on the server.
  ///
  /// The [imageUrl], [fadeOutDuration], [fadeOutCurve],
  /// [fadeInDuration], [fadeInCurve], [alignment], [repeat], and
  /// [matchTextDirection] arguments must not be null. Arguments [width],
  /// [height], [fit], [alignment], [repeat] and [matchTextDirection]
  /// are only used for the image and not for the placeholder.
  const CachedNetworkImage({
    Key key,
    this.placeholder,
    @required this.imageUrl,
    this.errorWidget,
    this.fadeOutDuration: const Duration(milliseconds: 300),
    this.fadeOutCurve: Curves.easeOut,
    this.fadeInDuration: const Duration(milliseconds: 700),
    this.fadeInCurve: Curves.easeIn,
    this.width,
    this.height,
    this.fit,
    this.alignment: Alignment.center,
    this.repeat: ImageRepeat.noRepeat,
    this.matchTextDirection: false,
    this.httpHeaders,
  })  : assert(imageUrl != null),
        assert(fadeOutDuration != null),
        assert(fadeOutCurve != null),
        assert(fadeInDuration != null),
        assert(fadeInCurve != null),
        assert(alignment != null),
        assert(repeat != null),
        assert(matchTextDirection != null),
        super(key: key);

  /// Widget displayed while the target [imageUrl] is loading.
  final Widget placeholder;

  /// The target image that is displayed.
  final String imageUrl;

  /// Widget displayed while the target [imageUrl] failed loading.
  final Widget errorWidget;

  /// The duration of the fade-out animation for the [placeholder].
  final Duration fadeOutDuration;

  /// The curve of the fade-out animation for the [placeholder].
  final Curve fadeOutCurve;

  /// The duration of the fade-in animation for the [imageUrl].
  final Duration fadeInDuration;

  /// The curve of the fade-in animation for the [imageUrl].
  final Curve fadeInCurve;

  /// If non-null, require the image to have this width.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio. This may result in a sudden change if the size of the
  /// placeholder widget does not match that of the target image. The size is
  /// also affected by the scale factor.
  final double width;

  /// If non-null, require the image to have this height.
  ///
  /// If null, the image will pick a size that best preserves its intrinsic
  /// aspect ratio. This may result in a sudden change if the size of the
  /// placeholder widget does not match that of the target image. The size is
  /// also affected by the scale factor.
  final double height;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit fit;

  /// How to align the image within its bounds.
  ///
  /// The alignment aligns the given position in the image to the given position
  /// in the layout bounds. For example, a [Alignment] alignment of (-1.0,
  /// -1.0) aligns the image to the top-left corner of its layout bounds, while a
  /// [Alignment] alignment of (1.0, 1.0) aligns the bottom right of the
  /// image with the bottom right corner of its layout bounds. Similarly, an
  /// alignment of (0.0, 1.0) aligns the bottom middle of the image with the
  /// middle of the bottom edge of its layout bounds.
  ///
  /// If the [alignment] is [TextDirection]-dependent (i.e. if it is a
  /// [AlignmentDirectional]), then an ambient [Directionality] widget
  /// must be in scope.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  /// Whether to paint the image in the direction of the [TextDirection].
  ///
  /// If this is true, then in [TextDirection.ltr] contexts, the image will be
  /// drawn with its origin in the top left (the "normal" painting direction for
  /// images); and in [TextDirection.rtl] contexts, the image will be drawn with
  /// a scaling factor of -1 in the horizontal direction so that the origin is
  /// in the top right.
  ///
  /// This is occasionally used with images in right-to-left environments, for
  /// images that were designed for left-to-right locales. Be careful, when
  /// using this, to not flip images with integral shadows, text, or other
  /// effects that will look incorrect when flipped.
  ///
  /// If this is true, there must be an ambient [Directionality] widget in
  /// scope.
  final bool matchTextDirection;

  // Optional headers for the http request of the image url
  final Map<String, String> httpHeaders;

  @override
  State<StatefulWidget> createState() => new _CachedNetworkImageState();
}

/// The phases a [CachedNetworkImage] goes through.
@visibleForTesting
enum ImagePhase {
  /// The initial state.
  ///
  /// We do not yet know whether the target image is ready and therefore no
  /// animation is necessary, or whether we need to use the placeholder and
  /// wait for the image to load.
  start,

  /// Waiting for the target image to load.
  waiting,

  /// Fading out previous image.
  fadeOut,

  /// Fading in new image.
  fadeIn,

  /// Fade-in complete.
  completed,
}

typedef void _ImageProviderResolverListener();

class _ImageProviderResolver {
  _ImageProviderResolver({
    @required this.state,
    @required this.listener,
  });

  final _CachedNetworkImageState state;
  final _ImageProviderResolverListener listener;

  CachedNetworkImage get widget => state.widget;

  ImageStream _imageStream;
  ImageInfo _imageInfo;

  void resolve(CachedNetworkImageProvider provider) {
    final ImageStream oldImageStream = _imageStream;
    _imageStream = provider.resolve(createLocalImageConfiguration(state.context,
        size: widget.width != null && widget.height != null
            ? new Size(widget.width, widget.height)
            : null));

    if (_imageStream.key != oldImageStream?.key) {
      oldImageStream?.removeListener(_handleImageChanged);
      _imageStream.addListener(_handleImageChanged);
    }
  }

  void _handleImageChanged(ImageInfo imageInfo, bool synchronousCall) {
    _imageInfo = imageInfo;
    listener();
  }

  void stopListening() {
    _imageStream?.removeListener(_handleImageChanged);
  }
}

class _CachedNetworkImageState extends State<CachedNetworkImage>
    with TickerProviderStateMixin {
  _ImageProviderResolver _imageResolver;
  CachedNetworkImageProvider _imageProvider;

  AnimationController _controller;
  Animation<double> _animation;

  ImagePhase _phase = ImagePhase.start;
  ImagePhase get phase => _phase;

  bool _hasError;

  @override
  void initState() {
    _hasError = false;
    _imageProvider = new CachedNetworkImageProvider(widget.imageUrl,
        headers: widget.httpHeaders, errorListener: _imageLoadingFailed);
    _imageResolver =
        new _ImageProviderResolver(state: this, listener: _updatePhase);

    _controller = new AnimationController(
      value: 1.0,
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        // Trigger rebuild to update opacity value.
      });
    });
    _controller.addStatusListener((AnimationStatus status) {
      _updatePhase();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _imageProvider
        .obtainKey(createLocalImageConfiguration(context))
        .then<void>((CachedNetworkImageProvider key) {
      if (CachedNetworkImage._registeredErrors.contains(key)) {
        setState(() => _hasError = true);
      }
    });

    _resolveImage();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(CachedNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != oldWidget.imageUrl ||
        widget.placeholder != widget.placeholder) {
      _imageProvider = new CachedNetworkImageProvider(widget.imageUrl,
          headers: widget.httpHeaders,
          errorListener: _imageLoadingFailed);

      _resolveImage();
    }
  }

  @override
  void reassemble() {
    _resolveImage(); // in case the image cache was flushed
    super.reassemble();
  }

  void _resolveImage() {
    _imageResolver.resolve(_imageProvider);

    if (_phase == ImagePhase.start) _updatePhase();
  }

  void _updatePhase() {
    setState(() {
      switch (_phase) {
        case ImagePhase.start:
          if (_imageResolver._imageInfo != null || _hasError)
            _phase = ImagePhase.completed;
          else
            _phase = ImagePhase.waiting;
          break;
        case ImagePhase.waiting:
          if (_hasError && widget.errorWidget == null) {
            _phase = ImagePhase.completed;
            return;
          }

          if (_imageResolver._imageInfo != null || _hasError) {
            if (widget.placeholder == null) {
              _startFadeIn();
            } else {
              _startFadeOut();
            }
          }
          break;
        case ImagePhase.fadeOut:
          if (_controller.status == AnimationStatus.dismissed) {
            _startFadeIn();
          }
          break;
        case ImagePhase.fadeIn:
          if (_controller.status == AnimationStatus.completed) {
            // Done finding in new image.
            _phase = ImagePhase.completed;
          }
          break;
        case ImagePhase.completed:
          // Nothing to do.
          break;
      }
    });
  }

  // Received image data. Begin placeholder fade-out.
  void _startFadeOut() {
    _controller.duration = widget.fadeOutDuration;
    _animation = new CurvedAnimation(
      parent: _controller,
      curve: widget.fadeOutCurve,
    );
    _phase = ImagePhase.fadeOut;
    _controller.reverse(from: 1.0);
  }

  // Done fading out placeholder. Begin target image fade-in.
  void _startFadeIn() {
    _controller.duration = widget.fadeInDuration;
    _animation = new CurvedAnimation(
      parent: _controller,
      curve: widget.fadeInCurve,
    );
    _phase = ImagePhase.fadeIn;
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _imageResolver.stopListening();
    _controller.dispose();
    super.dispose();
  }

  bool get _isShowingPlaceholder {
    assert(_phase != null);
    switch (_phase) {
      case ImagePhase.start:
      case ImagePhase.waiting:
      case ImagePhase.fadeOut:
        return true;
      case ImagePhase.fadeIn:
      case ImagePhase.completed:
        return _hasError && widget.errorWidget == null;
    }

    return null;
  }

  void _imageLoadingFailed() {
    _imageProvider
        .obtainKey(createLocalImageConfiguration(context))
        .then<void>((CachedNetworkImageProvider key) {
      if (!CachedNetworkImage._registeredErrors.contains(key)) {
        CachedNetworkImage._registeredErrors.add(key);
      }
    });
    _hasError = true;
    _updatePhase();
  }

  @override
  Widget build(BuildContext context) {
    assert(_phase != ImagePhase.start);
    if (_isShowingPlaceholder && widget.placeholder != null) {
      return _fadedWidget(widget.placeholder);
    }

    if (_hasError && widget.errorWidget != null) {
      return _fadedWidget(widget.errorWidget);
    }

    final ImageInfo imageInfo = _imageResolver._imageInfo;
    return new RawImage(
      image: imageInfo?.image,
      width: widget.width,
      height: widget.height,
      scale: imageInfo?.scale ?? 1.0,
      color: new Color.fromRGBO(255, 255, 255, _animation?.value ?? 1.0),
      colorBlendMode: BlendMode.modulate,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      matchTextDirection: widget.matchTextDirection,
    );
  }

  Widget _fadedWidget(Widget w) {
    return new Opacity(
      opacity: _animation?.value ?? 1.0,
      child: w,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(new EnumProperty<ImagePhase>('phase', _phase));
    description.add(new DiagnosticsProperty<ImageInfo>(
        'pixels', _imageResolver._imageInfo));
    description.add(new DiagnosticsProperty<ImageStream>(
        'image stream', _imageResolver._imageStream));
  }
}

typedef void ErrorListener();

class CachedNetworkImageProvider
    extends ImageProvider<CachedNetworkImageProvider> {
  /// Creates an ImageProvider which loads an image from the [url], using the [scale].
  /// When the image fails to load [errorListener] is called.
  const CachedNetworkImageProvider(this.url,
      {this.scale: 1.0, this.errorListener, this.headers})
      : assert(url != null),
        assert(scale != null);

  /// Web url of the image to load
  final String url;

  /// Scale of the image
  final double scale;

  /// Listener to be called when images fails to load.
  final ErrorListener errorListener;

  // Set headers for the image provider, for example for authentication
  final Map<String, String> headers;

  @override
  Future<CachedNetworkImageProvider> obtainKey(
      ImageConfiguration configuration) {
    return new SynchronousFuture<CachedNetworkImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(CachedNetworkImageProvider key) {
    return new MultiFrameImageStreamCompleter(
        codec: _loadAsync(key),
        scale: key.scale,
        informationCollector: (StringBuffer information) {
          information.writeln('Image provider: $this');
          information.write('Image key: $key');
        });
  }

  Future<ui.Codec> _loadAsync(CachedNetworkImageProvider key) async {
    var cacheManager = await CacheManager.getInstance();
    var file = await cacheManager.getFile(url, headers: headers);
    if (file == null) {
      if (errorListener != null) errorListener();
      return Future<ui.Codec>.error("Couldn't download or retreive file.");
    }
    return await _loadAsyncFromFile(key, file);
  }

  Future<ui.Codec> _loadAsyncFromFile(
      CachedNetworkImageProvider key, File file) async {
    assert(key == this);

    final Uint8List bytes = await file.readAsBytes();

    if (bytes.lengthInBytes == 0) {
      if (errorListener != null) errorListener();
      throw new Exception("File was empty");
    }

    return await ui.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final CachedNetworkImageProvider typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}
