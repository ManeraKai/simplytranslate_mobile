package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class PyrMeanShiftFilteringFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, spatialWindowRadius: Double, colorWindowRadius: Double, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(pyrMeanShiftFilteringS(pathString, spatialWindowRadius, colorWindowRadius))
                2 -> result.success(pyrMeanShiftFilteringB(data, spatialWindowRadius, colorWindowRadius))
                3 -> result.success(pyrMeanShiftFilteringB(data, spatialWindowRadius, colorWindowRadius))
            }
        }

        //Module: Image Filtering
        private fun pyrMeanShiftFilteringS(pathString: String, spatialWindowRadius: Double, colorWindowRadius: Double): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()
            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // pyrMeanShiftFiltering operation
                Imgproc.pyrMeanShiftFiltering(src, dst, spatialWindowRadius, colorWindowRadius)

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
        private fun pyrMeanShiftFilteringB(data: ByteArray, spatialWindowRadius: Double, colorWindowRadius: Double): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // pyrMeanShiftFiltering operation
                Imgproc.pyrMeanShiftFiltering(src, dst, spatialWindowRadius, colorWindowRadius)

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