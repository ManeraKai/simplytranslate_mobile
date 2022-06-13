package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.CvType
import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class MorphologyExFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, operation: Int, kernelSize: ArrayList<Int>, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(morphologyExS(pathString, operation, kernelSize))
                2 -> result.success(morphologyExB(data, operation, kernelSize))
                3 -> result.success(morphologyExB(data, operation, kernelSize))
            }
        }

        //Module: Image Filtering
        private fun morphologyExS(pathString: String, operation: Int, kernelSize: ArrayList<Int>): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)

                // Creating kernel matrix
                val kernel = Mat.ones(kernelSize[0], kernelSize[0], CvType.CV_32F)

                // Morphological operation
                Imgproc.morphologyEx(src, dst, operation, kernel)

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
        private fun morphologyExB(data: ByteArray, operation: Int, kernelSize: ArrayList<Int>): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)

                // Creating kernel matrix
                val kernel = Mat.ones(kernelSize[0], kernelSize[0], CvType.CV_32F)

                // Morphological operation
                Imgproc.morphologyEx(src, dst, operation, kernel)

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