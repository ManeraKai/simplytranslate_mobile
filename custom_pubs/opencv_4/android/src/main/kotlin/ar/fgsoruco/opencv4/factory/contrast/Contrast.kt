package ar.fgsoruco.opencv4.factory.contrast

import io.flutter.plugin.common.MethodChannel
import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc


class Contrast {
    companion object {
        fun process(
            pathString: String,
            alpha: Double,
            result: MethodChannel.Result
        ) {
            val filename = pathString.replace("file://", "")
            val src: org.opencv.core.Mat = Imgcodecs.imread(filename)
            src.convertTo(src, -1, alpha)
            val matOfByte = MatOfByte()
            Imgcodecs.imencode(".jpg", src, matOfByte)
            var byteArray = ByteArray(0)
            byteArray = matOfByte.toArray()
            result.success(byteArray)
        }
    }
}