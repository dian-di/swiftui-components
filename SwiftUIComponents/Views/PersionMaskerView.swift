import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI
import Vision

// MARK: - 1. 抠图工具
final class PersonMasker {
    private let request = VNGeneratePersonSegmentationRequest()
    private let context = CIContext()

    init() {
        request.qualityLevel = .balanced  // 快一点，不要求像素级
    }

    /// 返回：原图 + 人像 Alpha 通道（0/1 蒙版）
    func mask(from uiImage: UIImage) -> (UIImage, UIImage)? {
        guard let cg = uiImage.cgImage else { return nil }

        let handler = VNImageRequestHandler(cgImage: cg, options: [:])
        try? handler.perform([request])

        guard let result = request.results?.first else { return nil }
        let maskPixelBuffer = result.pixelBuffer

        // 把 CVPixelBuffer → CIImage → UIImage
        let maskCI = CIImage(cvPixelBuffer: maskPixelBuffer)
            .cropped(to: CGRect(origin: .zero, size: uiImage.size))  // Vision 给的尺寸可能略大
        let maskedCI = CIImage(image: uiImage)?
            .applyingFilter(
                "CIBlendWithMask",
                parameters: [kCIInputMaskImageKey: maskCI]
            )

        guard
            let maskedCG = context.createCGImage(
                maskedCI!,
                from: maskedCI!.extent
            ),
            let maskCG = context.createCGImage(maskCI, from: maskCI.extent)
        else { return nil }

        return (UIImage(cgImage: maskedCG), UIImage(cgImage: maskCG))
    }
}

// MARK: - 2. 把蒙版变成 SwiftUI Shape（方便描边 / 填充）
struct MaskShape: Shape {
    let mask: UIImage
    func path(in rect: CGRect) -> Path {
        guard let cg = mask.cgImage else { return Path() }
        // 简单做法：把 UIImage 转成灰度像素，>0.5 算“有人”
        let w = cg.width
        let h = cg.height
        let bytesPerRow = w
        var pixels = [UInt8](repeating: 0, count: w * h)
        let ctx = CGContext(
            data: &pixels,
            width: w,
            height: h,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceGray(),
            bitmapInfo: CGImageAlphaInfo.none.rawValue
        )!
        ctx.draw(cg, in: CGRect(x: 0, y: 0, width: w, height: h))

        let scaleX = rect.width / CGFloat(w)
        let scaleY = rect.height / CGFloat(h)

        var path = Path()
        for y in 0..<h {
            for x in 0..<w where pixels[y * w + x] > 128 {
                let pt = CGPoint(x: CGFloat(x) * scaleX, y: CGFloat(y) * scaleY)
                path.addRect(
                    CGRect(
                        origin: pt,
                        size: CGSize(width: scaleX, height: scaleY)
                    )
                )
            }
        }
        return path
    }
}

// MARK: - 3. 贴纸模型 & 视图
struct Sticker: Identifiable {
    let id = UUID()
    var offset: CGSize = .zero
    var rotation: Angle = .zero
    var scale: CGFloat = 1
    let image: Image
}

struct StickerView: View {
    @Binding var sticker: Sticker
    var body: some View {
        sticker.image
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .rotationEffect(sticker.rotation)
            .scaleEffect(sticker.scale)
            .offset(sticker.offset)
            .gesture(
                DragGesture()
                    .onChanged { sticker.offset = $0.translation }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { sticker.scale = $0 }
            )
            .gesture(
                RotationGesture()
                    .onChanged { sticker.rotation = $0 }
            )
    }
}

// MARK: - 4. 主界面
struct PersonMaskerView: View {
    @State private var inputImage: UIImage?
    @State private var maskedImage: UIImage?
    @State private var maskShape: MaskShape?
    @State private var stickers: [Sticker] = []
    @State private var selectedItem: PhotosPickerItem?  // ← 新增

    private let masker = PersonMasker()

    var body: some View {
        VStack {
            if let masked = maskedImage {
                ZStack {
                    Image(uiImage: masked)
                        .resizable()
                        .scaledToFit()

                    // 描边
                    if let shape = maskShape {
                        shape.stroke(Color.red, lineWidth: 4)
                            .blendMode(.overlay)
                    }

                    // 贴纸
                    ForEach($stickers) { $st in
                        StickerView(sticker: $st)
                    }
                }
            } else {
                PhotosPicker("选照片", selection: $selectedItem, matching: .images)
            }
        }
        .onChange(of: selectedItem) { _, newItem in
            loadImage(from: newItem)
        }
    }

    private func loadImage(from item: PhotosPickerItem?) {
        Task {
            guard let data = try? await item?.loadTransferable(type: Data.self),
                let img = UIImage(data: data)
            else { return }
            await MainActor.run {
                inputImage = img
                if let (masked, mask) = masker.mask(from: img) {
                    maskedImage = masked
                    maskShape = MaskShape(mask: mask)
                    stickers = [Sticker(image: Image(systemName: "heart.fill"))]
                }
            }
        }
    }
}

#Preview {
    PersonMaskerView()
}
