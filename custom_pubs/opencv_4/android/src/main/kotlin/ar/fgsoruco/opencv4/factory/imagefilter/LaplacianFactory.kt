package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class LaplacianFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, depth: Int, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(laplacianS(pathString, depth))
                2 -> result.success(laplacianB(data, depth))
                3 -> result.success(laplacianB(data, depth))
            }
        }

        //Module: Image Filtering
        private fun laplacianS(pathString: String, depth: Int): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)

                // Laplacian operation
                Imgproc.Laplacian(src, dst, depth)

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
        private fun laplacianB(data: ByteArray, depth: Int): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)

                // Laplacian operation
                Imgproc.Laplacian(src, dst, depth)

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