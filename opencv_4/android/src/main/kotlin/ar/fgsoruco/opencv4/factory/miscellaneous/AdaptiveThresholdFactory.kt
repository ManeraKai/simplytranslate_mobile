package ar.fgsoruco.opencv4.factory.miscellaneous

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class AdaptiveThresholdFactory {
    companion object{
        fun process(pathType: Int,pathString: String, data: ByteArray, maxValue: Double, adaptiveMethod: Int, thresholdType: Int,
                    blockSize: Int, constantValue: Double, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(adaptiveThresholdS(pathString, maxValue, adaptiveMethod, thresholdType,
                        blockSize, constantValue))
                2 -> result.success(adaptiveThresholdB(data, maxValue, adaptiveMethod, thresholdType,
                        blockSize, constantValue))
                3 -> result.success(adaptiveThresholdB(data, maxValue, adaptiveMethod, thresholdType,
                        blockSize, constantValue))
            }
        }

        //Module: Miscellaneous Image Transformations
        private fun adaptiveThresholdS(pathString: String, maxValue: Double, adaptiveMethod: Int, thresholdType: Int,
                                       blockSize: Int, constantValue: Double): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val srcGray = Mat()
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // Convert the image to Gray
                Imgproc.cvtColor(src, srcGray, Imgproc.COLOR_BGR2GRAY)

                // Adaptive Thresholding
                Imgproc.adaptiveThreshold(srcGray, dst, maxValue, adaptiveMethod, thresholdType, blockSize, constantValue)

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

        //Module: Miscellaneous Image Transformations
        private fun adaptiveThresholdB(data: ByteArray, maxValue: Double, adaptiveMethod: Int, thresholdType: Int,
                                       blockSize: Int, constantValue: Double): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val srcGray = Mat()
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // Convert the image to Gray
                Imgproc.cvtColor(src, srcGray, Imgproc.COLOR_BGR2GRAY)

                // Adaptive Thresholding
                Imgproc.adaptiveThreshold(srcGray, dst, maxValue, adaptiveMethod, thresholdType, blockSize, constantValue)

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