package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class BilateralFilterFactory {
    companion object{
        fun process(pathType: Int,pathString: String, data: ByteArray, diameter: Int, sigmaColor:Int, sigmaSpace:Int, borderType: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(bilateralFilterS(pathString, diameter, sigmaColor, sigmaSpace, borderType))
                2 -> result.success(bilateralFilterB(data, diameter, sigmaColor, sigmaSpace, borderType))
                3 -> result.success(bilateralFilterB(data, diameter, sigmaColor, sigmaSpace, borderType))
            }
        }

        private fun bilateralFilterS(pathString: String, diameter: Int, sigmaColor: Int, sigmaSpace: Int, borderType: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                val srcRgb = Mat()
                Imgproc.cvtColor(src, srcRgb, Imgproc.COLOR_BGRA2BGR, 0)
                Imgproc.bilateralFilter(srcRgb, dst, diameter, sigmaColor.toDouble(), sigmaSpace.toDouble(), borderType)
                val matOfByte = MatOfByte()
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                return byteArray
            } catch (e: java.lang.Exception) {
                println("OpenCV Error: $e")
                return data
            }

        }

        private fun bilateralFilterB(data: ByteArray, diameter: Int, sigmaColor: Int, sigmaSpace: Int, borderType: Int): ByteArray? {

            return try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                val srcRgb = Mat()
                Imgproc.cvtColor(src, srcRgb, Imgproc.COLOR_BGRA2BGR, 0)
                Imgproc.bilateralFilter(srcRgb, dst, diameter, sigmaColor.toDouble(), sigmaSpace.toDouble(), borderType)
                val matOfByte = MatOfByte()
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                byteArray
            } catch (e: java.lang.Exception) {
                println("OpenCV Error: $e")
                data
            }

        }

    }
}