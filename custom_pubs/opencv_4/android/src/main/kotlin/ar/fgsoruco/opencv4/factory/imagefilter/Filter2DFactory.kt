package ar.fgsoruco.opencv4.factory.imagefilter

import org.opencv.core.CvType
import org.opencv.core.Mat
import org.opencv.core.MatOfByte
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel

class Filter2DFactory {
    companion object{

        fun process(pathType: Int,pathString: String, data: ByteArray, outputDepth: Int, kernelSize: ArrayList<Int>, result: MethodChannel.Result) {
            when (pathType){
                1 -> result.success(filter2DS(pathString, outputDepth, kernelSize))
                2 -> result.success(filter2DB(data, outputDepth, kernelSize))
                3 -> result.success(filter2DB(data, outputDepth, kernelSize))
            }
        }

        //Module: Image Filtering
        private fun filter2DS(pathString: String, outputDepth: Int, kernelSize: ArrayList<Int>): ByteArray? {
            val inputStream: InputStream = FileInputStream(pathString.replace("file://", ""))
            val data: ByteArray = inputStream.readBytes()

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val filename = pathString.replace("file://", "")
                val src = Imgcodecs.imread(filename)

                // Creating kernel matrix
                val kernel = Mat.ones(kernelSize[0], kernelSize[1], CvType.CV_32F)
                for (i in 0 until kernel.rows()) {
                    for (j in 0 until kernel.cols()) {
                        val m = kernel[i, j]
                        for (k in 1 until m.size) {
                            m[k] = m[k] / (2 * 2)
                        }
                        kernel.put(i, j, *m)
                    }
                }
                // Convert the image to Gray
                Imgproc.filter2D(src, dst, outputDepth, kernel)
                val matOfByte = MatOfByte()
                Imgcodecs.imencode(".jpg", dst, matOfByte)
                byteArray = matOfByte.toArray()
                return byteArray
            } catch (e: java.lang.Exception) {
                println("OpenCV Error: $e")
                return data
            }

        }

        //Module: Image Filtering
        private fun filter2DB(data: ByteArray, outputDepth: Int, kernelSize: ArrayList<Int>): ByteArray? {

            try {
                var byteArray = ByteArray(0)
                val dst = Mat()
                // Decode image from input byte array
                val src = Imgcodecs.imdecode(MatOfByte(*data), Imgcodecs.IMREAD_UNCHANGED)

                // Creating kernel matrix
                var m: DoubleArray;
                val kernel = Mat.ones(kernelSize[0], kernelSize[1], CvType.CV_32F)
                for (i in 0 until kernel.rows()) {
                    for (j in 0 until kernel.cols()) {
                        m = kernel[i, j]
                        for (k in 1 until m.size) {
                            m[k] = m[k] / (2 * 2)
                        }
                        kernel.put(i, j, *m)
                    }
                }
                // Convert the image to Gray
                Imgproc.filter2D(src, dst, outputDepth, kernel)

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