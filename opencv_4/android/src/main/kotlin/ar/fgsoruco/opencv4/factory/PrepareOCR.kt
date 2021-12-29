package ar.fgsoruco.opencv4.factory.PrepareOCR

import io.flutter.plugin.common.MethodChannel
import org.opencv.core.*
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import org.opencv.core.Mat


class PrepareOCR {
    companion object {
        fun process(
            pathString: String,
            result: MethodChannel.Result
        ) {
            val filename = pathString.replace("file://", "")
            val src: org.opencv.core.Mat = Imgcodecs.imread(filename)

            Imgproc.cvtColor(src, src, Imgproc.COLOR_RGB2GRAY)
            var se = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, Size(8.0, 8.0))
            var bg = Mat()
            Imgproc.morphologyEx(src, bg, Imgproc.MORPH_DILATE, se)
            var wewe = Mat()
            Core.divide(src, bg, wewe, 255.0)
//            Imgproc.adaptiveThreshold(
//                wewe,
//                wewe,
//                255.0,
//                Imgproc.ADAPTIVE_THRESH_GAUSSIAN_C,
//                Imgproc.THRESH_BINARY,
//                15,
//                40.0
//            );
            Imgproc.threshold(wewe, wewe, 0.0, 255.0, Imgproc.THRESH_OTSU)
            Imgproc.dilate(
                wewe, wewe, Imgproc.getStructuringElement(
                    Imgproc.MORPH_DILATE,
                    Size(1.0, 1.0)
                )
            )
            val matOfByte = MatOfByte()
            Imgcodecs.imencode(".jpg", wewe, matOfByte)
            var byteArray = ByteArray(0)
            byteArray = matOfByte.toArray()
            result.success(byteArray)
        }
    }
}

//var dilatedImg = Mat()
//            Imgproc.dilate(
//                src, dilatedImg, Imgproc.getStructuringElement(
//                    Imgproc.MORPH_RECT,
//                    Size(7.0, 7.0)
//                )
//            )
//            Imgproc.medianBlur(dilatedImg, dilatedImg, 21)
//
//            var diffImg = Mat()
//            Core.absdiff(src, dilatedImg, diffImg)
//
//            Core.normalize(diffImg, diffImg, 0.0, 255.0, Core.NORM_MINMAX, CvType.CV_8UC1)
//            Imgproc.threshold(diffImg, diffImg, 230.0, 0.0, Imgproc.THRESH_TRUNC)
//            Core.normalize(diffImg, diffImg, 230.0, 0.0, Core.NORM_MINMAX, CvType.CV_8UC1)
//            diffImg.convertTo(diffImg, -1, 1.5)