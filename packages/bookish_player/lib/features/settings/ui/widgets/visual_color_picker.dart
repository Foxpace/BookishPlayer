import 'package:flutter/material.dart';

class VisualColorPicker extends StatelessWidget {
  const VisualColorPicker({
    required this.color,
    required this.fieldSemanticLabel,
    required this.hueSemanticLabel,
    required this.onChanged,
    super.key,
  });

  final Color color;
  final String fieldSemanticLabel;
  final String hueSemanticLabel;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    final hsv = HSVColor.fromColor(color);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ColorField(
          color: hsv,
          semanticLabel: fieldSemanticLabel,
          onChanged: (selection) => onChanged(
            hsv
                .withSaturation(selection.saturation)
                .withValue(selection.value)
                .toColor(),
          ),
        ),
        const SizedBox(height: 12),
        _HueStrip(
          hue: hsv.hue,
          semanticLabel: hueSemanticLabel,
          onChanged: (hue) => onChanged(hsv.withHue(hue).toColor()),
        ),
        const SizedBox(height: 12),
        _ColorPreview(color: color),
      ],
    );
  }
}

class _ColorField extends StatelessWidget {
  const _ColorField({
    required this.color,
    required this.semanticLabel,
    required this.onChanged,
  });

  final HSVColor color;
  final String semanticLabel;
  final ValueChanged<({double saturation, double value})> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      value: _hex(color.toColor()),
      child: AspectRatio(
        aspectRatio: 1.5,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            void select(Offset position) => onChanged((
              saturation: (position.dx / size.width).clamp(0, 1),
              value: 1 - (position.dy / size.height).clamp(0, 1),
            ));
            return GestureDetector(
              key: const ValueKey('primary-color-field'),
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) => select(details.localPosition),
              onPanDown: (details) => select(details.localPosition),
              onPanUpdate: (details) => select(details.localPosition),
              child: CustomPaint(painter: _ColorFieldPainter(color: color)),
            );
          },
        ),
      ),
    );
  }
}

class _ColorFieldPainter extends CustomPainter {
  const _ColorFieldPainter({required this.color});

  final HSVColor color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const radius = Radius.circular(14);
    canvas.save();
    canvas.clipRRect(RRect.fromRectAndRadius(rect, radius));
    canvas.drawRect(
      rect,
      Paint()..color = HSVColor.fromAHSV(1, color.hue, 1, 1).toColor(),
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          colors: [Colors.white, Colors.transparent],
        ).createShader(rect),
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black],
        ).createShader(rect),
    );
    canvas.restore();
    _paintHandle(canvas, size);
  }

  void _paintHandle(Canvas canvas, Size size) {
    final center = Offset(
      color.saturation * size.width,
      (1 - color.value) * size.height,
    );
    canvas.drawCircle(center, 9, Paint()..color = Colors.white);
    canvas.drawCircle(center, 7, Paint()..color = color.toColor());
    canvas.drawCircle(
      center,
      9,
      Paint()
        ..color = Colors.black54
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_ColorFieldPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _HueStrip extends StatelessWidget {
  const _HueStrip({
    required this.hue,
    required this.semanticLabel,
    required this.onChanged,
  });

  final double hue;
  final String semanticLabel;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      slider: true,
      label: semanticLabel,
      value: '${hue.round()}°',
      increasedValue: '${(hue + 5).clamp(0, 360).round()}°',
      decreasedValue: '${(hue - 5).clamp(0, 360).round()}°',
      onIncrease: () => onChanged((hue + 5).clamp(0, 360)),
      onDecrease: () => onChanged((hue - 5).clamp(0, 360)),
      child: SizedBox(
        height: 40,
        child: LayoutBuilder(
          builder: (context, constraints) {
            void select(Offset position) => onChanged(
              (position.dx / constraints.maxWidth * 360).clamp(0, 360),
            );
            return GestureDetector(
              key: const ValueKey('primary-color-hue-strip'),
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) => select(details.localPosition),
              onPanDown: (details) => select(details.localPosition),
              onPanUpdate: (details) => select(details.localPosition),
              child: Stack(
                children: [
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: 12,
                    child: _HueGradientTrack(),
                  ),
                  Positioned(
                    left: hue / 360 * (constraints.maxWidth - 20),
                    top: 10,
                    child: _HueHandle(hue: hue),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HueGradientTrack extends StatelessWidget {
  const _HueGradientTrack();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF0000),
            Color(0xFFFFFF00),
            Color(0xFF00FF00),
            Color(0xFF00FFFF),
            Color(0xFF0000FF),
            Color(0xFFFF00FF),
            Color(0xFFFF0000),
          ],
        ),
      ),
    );
  }
}

class _HueHandle extends StatelessWidget {
  const _HueHandle({required this.hue});

  final double hue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: HSVColor.fromAHSV(1, hue, 1, 1).toColor(),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 1)],
      ),
    );
  }
}

class _ColorPreview extends StatelessWidget {
  const _ColorPreview({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        const SizedBox(width: 12),
        Text(_hex(color), style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

String _hex(Color color) {
  final value = color.toARGB32() & 0xFFFFFF;
  return '#${value.toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
