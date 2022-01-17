package ar.fgsoruco.opencv4.factory.colormaps

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class ApplyColorMapFactory {

    companion object{
        fun process(pathType: Int,pathString: String, data: ByteArray, colorMap: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(applyColorMapS(pathString, colorMap))
                2 -> result.success(applyColorMapB(data, colorMap))
                3 -> result.success(applyColorMapB(data, colorMap))
            }
        }

        //Module: ColorMaps in OpenCV
        private fun applyColorMapS(pathString: String, colorMap: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)

                // resize operation
                Imgproc.applyColorMap(src, dst, colorMap)

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

        private fun applyColorMapB(data: ByteArray, colorMap: Int): ByteArray? {
            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)
                Imgproc.applyColorMap(src, dst, colorMap)
                val matOfByte = MatOfByte()
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