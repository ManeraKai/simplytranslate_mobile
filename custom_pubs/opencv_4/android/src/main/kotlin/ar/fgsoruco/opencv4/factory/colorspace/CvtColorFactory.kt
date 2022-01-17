package ar.fgsoruco.opencv4.factory.colorspace

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class CvtColorFactory {
    companion object{
        fun process(pathType: Int, pathString: String, data: ByteArray, outputType: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(cvtColorS(pathString, outputType))
                2 -> result.success(cvtColorB(data, outputType))
                3 -> result.success(cvtColorB(data, outputType))
            }
        }

        private fun cvtColorS(pathString: String, outputType: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()
            return try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                Imgproc.cvtColor(src, dst, outputType)
                val matOfByte = MatOfByte()
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                byteArray
            } catch (e: Exception) {
                data
            }
        }

        private fun cvtColorB(data: ByteArray, outputType: Int): ByteArray? {
            return try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                Imgproc.cvtColor(src, dst, outputType)
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