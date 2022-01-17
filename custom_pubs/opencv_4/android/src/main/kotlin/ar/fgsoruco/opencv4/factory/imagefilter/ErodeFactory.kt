package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.core.Size
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class ErodeFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, kernelSize: ArrayList<Double>, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(erodeS(pathString, kernelSize))
                2 -> result.success(erodeB(data, kernelSize))
                3 -> result.success(erodeB(data, kernelSize))
            }
        }

        //Module: Image Filtering
        private fun erodeS(pathString: String, kernelSize: ArrayList<Double>): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)

                // Preparing the kernel matrix object
                val kernel = Imgproc.getStructuringElement(Imgproc.MORPH_RECT,
                        Size((kernelSize[0] * kernelSize[1] + 1),
                                (kernelSize[0] * kernelSize[1] + 1)))

                // Convert the image to Gray
                Imgproc.erode(src, dst, kernel)

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
        private fun erodeB(data: ByteArray, kernelSize: ArrayList<Double>): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)

                // Preparing the kernel matrix object
                val kernel = Imgproc.getStructuringElement(Imgproc.MORPH_RECT,
                        Size((kernelSize[0] * kernelSize[1] + 1),
                                (kernelSize[0] * kernelSize[1] + 1)))

                // Convert the image to Gray
                Imgproc.erode(src, dst, kernel)

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