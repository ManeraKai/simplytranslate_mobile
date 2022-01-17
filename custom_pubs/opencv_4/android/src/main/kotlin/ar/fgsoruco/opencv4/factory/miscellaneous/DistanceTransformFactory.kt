package ar.fgsoruco.opencv4.factory.miscellaneous

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class DistanceTransformFactory {
    companion object{
        fun process(pathType: Int, pathString: String, data: ByteArray, distanceType: Int, maskSize: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(distanceTransformS(pathString, distanceType, maskSize))
                2 -> result.success(distanceTransformB(data, distanceType, maskSize))
                3 -> result.success(distanceTransformB(data, distanceType, maskSize))
            }
        }

        //Module: Miscellaneous Image Transformations
        private fun distanceTransformS(pathString: String, distanceType: Int, maskSize: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                // distanceTransform operation
                Imgproc.distanceTransform(src, dst, distanceType, maskSize)
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
        private fun distanceTransformB(data: ByteArray, distanceType: Int, maskSize: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                // distanceTransform operation
                Imgproc.distanceTransform(src, dst, distanceType, maskSize)
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