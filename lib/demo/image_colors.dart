//import 'package:palette_generator/palette_generator.dart';
import 'package:doubanapp/util/palette_generator.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


const Color _kBackgroundColor = Color(0xffa0a0a0);
const Color _kSelectionRectangleBackground = Color(0x15000000);
const Color _kSelectionRectangleBorder = Color(0x80000000);
const Color _kPlaceholderColor = Color(0x80404040);

/// The home page for this example app.
@immutable
class ImageColors extends StatefulWidget {
  /// Creates the home page.
  const ImageColors({
    Key key,
    this.title,
    this.image,
    this.imageSize,
  }) : super(key: key);

  /// The title that is shown at the top of the page.
  final String title;

  /// This is the image provider that is used to load the colors from.
  final ImageProvider image;

  /// The dimensions of the image.
  final Size imageSize;

  @override
  _ImageColorsState createState() {
    return _ImageColorsState();
  }
}

class _ImageColorsState extends State<ImageColors> {
  Rect region;
  Rect dragRegion;
  Offset startDrag;
  Offset currentDrag;
  PaletteGenerator paletteGenerator;

  final GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    region = Offset.zero & widget.imageSize;
    _updatePaletteGenerator(region);
  }

  Future<void> _updatePaletteGenerator(Rect newRegion) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      widget.image,
      size: widget.imageSize,
      region: newRegion,
      maximumColorCount: 20,
    );
    setState(() {});
  }

  // Called when the user starts to drag
  void _onPanDown(DragDownDetails details) {
    final RenderBox box = imageKey.currentContext.findRenderObject();
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    setState(() {
      startDrag = localPosition;
      currentDrag = startDrag;
      dragRegion = Rect.fromPoints(startDrag, currentDrag);
    });
  }

  // Called as the user drags: just updates the region, not the colors.
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      currentDrag += details.delta;
      dragRegion = Rect.fromPoints(startDrag, currentDrag);
    });
  }

  // Called if the drag is canceled (e.g. by rotating the device or switching
  // apps)
  void _onPanCancel() {
    setState(() {
      dragRegion = null;
      startDrag = null;
    });
  }

  // Called when the drag ends. Sets the region, and updates the colors.
  void _onPanEnd(DragEndDetails details) async {
    Rect newRegion =
    (Offset.zero & imageKey.currentContext.size).intersect(dragRegion);
    if (newRegion.size.width < 4 && newRegion.size.width < 4) {
      newRegion = Offset.zero & imageKey.currentContext.size;
    }
    await _updatePaletteGenerator(newRegion);
    setState(() {
      region = newRegion;
      dragRegion = null;
      startDrag = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            // GestureDetector is used to handle the selection rectangle.
            child: GestureDetector(
              onPanDown: _onPanDown,
              onPanUpdate: _onPanUpdate,
              onPanCancel: _onPanCancel,
              onPanEnd: _onPanEnd,
              child: Stack(children: <Widget>[
                Image(
                  key: imageKey,
                  image: widget.image,
                  width: widget.imageSize.width,
                  height: widget.imageSize.height,
                ),
                // This is the selection rectangle.
                Positioned.fromRect(
                    rect: dragRegion ?? region ?? Rect.zero,
                    child: Container(
                      decoration: BoxDecoration(
                          color: _kSelectionRectangleBackground,
                          border: Border.all(
                            width: 1.0,
                            color: _kSelectionRectangleBorder,
                            style: BorderStyle.solid,
                          )),
                    )),
              ]),
            ),
          ),
          // Use a FutureBuilder so that the palettes will be displayed when
          // the palette generator is done generating its data.
          PaletteSwatches(generator: paletteGenerator),
        ],
      ),
    );
  }
}

/// A widget that draws the swatches for the [PaletteGenerator] it is given,
/// and shows the selected target colors.
class PaletteSwatches extends StatelessWidget {
  /// Create a Palette swatch.
  ///
  /// The [generator] is optional. If it is null, then the display will
  /// just be an empty container.
  const PaletteSwatches({Key key, this.generator}) : super(key: key);

  /// The [PaletteGenerator] that contains all of the swatches that we're going
  /// to display.
  final PaletteGenerator generator;

  @override
  Widget build(BuildContext context) {
    final List<Widget> swatches = <Widget>[];
    if (generator == null || generator.colors.isEmpty) {
      return Container();
    }
    for (Color color in generator.colors) {
      swatches.add(PaletteSwatch(color: color));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: swatches,
        ),
        Container(height: 30.0),
        PaletteSwatch(label: 'Dominant', color: generator.dominantColor?.color),
        PaletteSwatch(
            label: 'Light Vibrant', color: generator.lightVibrantColor?.color),
        PaletteSwatch(label: 'Vibrant', color: generator.vibrantColor?.color),
        PaletteSwatch(
            label: 'Dark Vibrant', color: generator.darkVibrantColor?.color),
        PaletteSwatch(
            label: 'Light Muted', color: generator.lightMutedColor?.color),
        PaletteSwatch(label: 'Muted', color: generator.mutedColor?.color),
        PaletteSwatch(
            label: 'Dark Muted', color: generator.darkMutedColor?.color),
      ],
    );
  }
}

/// A small square of color with an optional label.
@immutable
class PaletteSwatch extends StatelessWidget {
  /// Creates a PaletteSwatch.
  ///
  /// If the [color] argument is omitted, then the swatch will show a
  /// placeholder instead, to indicate that there is no color.
  const PaletteSwatch({
    Key key,
    this.color,
    this.label,
  }) : super(key: key);

  /// The color of the swatch. May be null.
  final Color color;

  /// The optional label to display next to the swatch.
  final String label;

  @override
  Widget build(BuildContext context) {
    // Compute the "distance" of the color swatch and the background color
    // so that we can put a border around those color swatches that are too
    // close to the background's saturation and lightness. We ignore hue for
    // the comparison.
    final HSLColor hslColor = HSLColor.fromColor(color ?? Colors.transparent);
    final HSLColor backgroundAsHsl = HSLColor.fromColor(_kBackgroundColor);
    final double colorDistance = math.sqrt(
        math.pow(hslColor.saturation - backgroundAsHsl.saturation, 2.0) +
            math.pow(hslColor.lightness - backgroundAsHsl.lightness, 2.0));

    Widget swatch = Padding(
      padding: const EdgeInsets.all(2.0),
      child: color == null
          ? const Placeholder(
        fallbackWidth: 34.0,
        fallbackHeight: 20.0,
        color: Color(0xff404040),
        strokeWidth: 2.0,
      )
          : Container(
        decoration: BoxDecoration(
            color: color,
            border: Border.all(
              width: 1.0,
              color: _kPlaceholderColor,
              style: colorDistance < 0.2
                  ? BorderStyle.solid
                  : BorderStyle.none,
            )),
        width: 34.0,
        height: 20.0,
      ),
    );

    if (label != null) {
      swatch = ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 130.0, minWidth: 130.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            swatch,
            Container(width: 5.0),
            Text(label),
          ],
        ),
      );
    }
    return swatch;
  }
}