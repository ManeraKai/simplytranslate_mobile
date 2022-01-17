package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class MedianBlurFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, kernelSize: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(medianBlurS(pathString, kernelSize))
                2 -> result.success(medianBlurB(data, kernelSize))
                3 -> result.success(medianBlurB(data, kernelSize))
            }
        }

        //Module: Image Filtering
        private fun medianBlurS(pathString: String, kernelSize: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // Convert the image to Gray
                Imgproc.medianBlur(src, dst, kernelSize)

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
        private fun medianBlurB(data: ByteArray, kernelSize: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // Convert the image to Gray
                Imgproc.medianBlur(src, dst, kernelSize)

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