package ar.fgsoruco.opencv4.factory.miscellaneous

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class ThresholdFactory {
    companion object{
        fun process(pathType: Int,pathData: String, data: ByteArray, thresholdValue: Double, maxThresholdValue: Double, thresholdType: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(thresholdS(pathData, thresholdValue, maxThresholdValue, thresholdType))
                2 -> result.success(thresholdB(data, thresholdValue, maxThresholdValue, thresholdType))
                3 -> result.success(thresholdB(data, thresholdValue, maxThresholdValue, thresholdType))
            }
        }

        //Module: Miscellaneous Image Transformations
        private fun thresholdS(pathData: String, thresholdValue: Double, maxThresholdValue: Double, thresholdType: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathData.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val srcGray = Mat()
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathData.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // Convert the image to Gray
                Imgproc.cvtColor(src, srcGray, Imgproc.COLOR_BGR2GRAY)

                // Thresholding
                Imgproc.threshold(srcGray, dst, thresholdValue, maxThresholdValue, thresholdType)

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
        private fun thresholdB(data: ByteArray, thresholdValue: Double, maxThresholdValue: Double, thresholdType: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val srcGray = Mat()
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // Convert the image to Gray
                Imgproc.cvtColor(src, srcGray, Imgproc.COLOR_BGR2GRAY)

                // Thresholding
                Imgproc.threshold(srcGray, dst, thresholdValue, maxThresholdValue, thresholdType)

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