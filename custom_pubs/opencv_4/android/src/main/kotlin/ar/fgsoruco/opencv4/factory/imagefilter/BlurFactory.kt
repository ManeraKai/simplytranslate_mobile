package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.core.Point
import org.opencv.core.Size
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class BlurFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, kernelSize:ArrayList<Double>, anchorPoint:ArrayList<Double>, borderType: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(blurS(pathString, kernelSize, anchorPoint, borderType))
                2 -> result.success(blurB(data, kernelSize, anchorPoint, borderType))
                3 -> result.success(blurB(data, kernelSize, anchorPoint, borderType))
            }
        }

        //Module: Image Filtering
        private fun blurS(pathData: String, kernelSize: ArrayList<Double>, anchorPoint: ArrayList<Double>, borderType: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathData.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathData.replace("file://", "")
                val src = Imgcodecs.imread(filename)
                val size = Size(kernelSize[0], kernelSize[1])
                val point = Point(anchorPoint[0], anchorPoint[1])
                // Convert the image to Gray
                Imgproc.blur(src, dst, size, point, borderType)

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

        private fun blurB(data: ByteArray, kernelSize: ArrayList<Double>, anchorPoint: ArrayList<Double>, borderType: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                val size = Size(kernelSize[0], kernelSize[1])
                val point = Point(anchorPoint[0], anchorPoint[1])
                // Convert the image to Gray
                Imgproc.blur(src, dst, size, point, borderType)

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