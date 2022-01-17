package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class SobelFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, depth: Int, dx: Int, dy: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(sobelS(pathString, depth, dx, dy))
                2 -> result.success(sobelB(data, depth, dx, dy))
                3 -> result.success(sobelB(data, depth, dx, dy))
            }
        }

        //Module: Image Filtering
        private fun sobelS(pathString: String, depth: Int, dx: Int, dy: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()
            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // Sobel operation
                Imgproc.Sobel(src, dst, depth, dx, dy)

                // instantiating an empty MatOfByte class
                val matOfByte = MatOfByte()
                // Converting the Mat object to MatOfByte
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                return byteArray
            } catch (e: java.lang.Exception) {
                println("OpenCV Error: $e")
                return data
            }

        }

        //Module: Image Filtering
        private fun sobelB(data: ByteArray, depth: Int, dx: Int, dy: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // Sobel operation
                Imgproc.Sobel(src, dst, depth, dx, dy)

                // instantiating an empty MatOfByte class
                val matOfByte = MatOfByte()
                // Converting the Mat object to MatOfByte
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                return byteArray
            } catch (e: java.lang.Exception) {
                println("OpenCV Error: $e")
                return data
            }

        }

    }
}