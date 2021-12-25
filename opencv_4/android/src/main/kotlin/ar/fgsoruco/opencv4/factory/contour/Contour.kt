package ar.fgsoruco.opencv4.factory.contour

import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc
import java.io.FileInputStream
import java.io.InputStream
import io.flutter.plugin.common.MethodChannel
import org.opencv.core.*
import java.util.ArrayList
import org.opencv.core.Scalar

import org.opencv.core.Core


class Contour {
    companion object {
        var publiCcontours: MutableList<MatOfPoint> = ArrayList<MatOfPoint>()
        fun processBytes(pathType: Int, pathString: String, result: MethodChannel.Result) {
            // Mat(src.size(), src.type())
            val filename = pathString.replace("file://", "")
            val src: org.opencv.core.Mat = Imgcodecs.imread(filename)
            val contours: MutableList<MatOfPoint> = ArrayList<MatOfPoint>()

            val processed = Mat(src.height(), src.width(), src.type())
            Imgproc.GaussianBlur(src, processed, Size(7.0, 7.0), 1.0)
            Imgproc.cvtColor(processed, processed, Imgproc.COLOR_BGR2GRAY)
            Imgproc.threshold(
                processed,
                processed,
                0.0,
                255.0,
                Imgproc.THRESH_OTSU + Imgproc.THRESH_BINARY_INV
            )
            var rectKernel = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, Size(18.0, 18.0))
            Imgproc.dilate(processed, processed, rectKernel, Point(-1.0, -1.0))
            Imgproc.findContours(
                processed,
                contours,
                Mat(),
                Imgproc.RETR_EXTERNAL,
                Imgproc.CHAIN_APPROX_SIMPLE
            )

            publiCcontours = contours

//            Imgproc.rectangle(
//                src,
//                Point(pos.x.toDouble(), pos.y.toDouble()),
//                Point((pos.x + pos.width).toDouble(), (pos.y + pos.height).toDouble()),
//                Scalar(0.0, 255.0, 0.0),
//                2
//            )

            var resultList: MutableList<ByteArray> = mutableListOf<ByteArray>()

            for (cnt in contours) {
                var pos = Imgproc.boundingRect(cnt)

                var roi = Rect(pos.x, pos.y, pos.width, pos.height)
                var cropped = Mat(src, roi)
                val matOfByte = MatOfByte()
                Imgcodecs.imencode(".jpg", cropped, matOfByte)
                var byteArray = ByteArray(0)
                byteArray = matOfByte.toArray()
                resultList.add(byteArray)
            }
            result.success(resultList)
        }

        fun processVals(result: MethodChannel.Result) {
            var resultList: MutableList<MutableMap<String, Int>> = mutableListOf()
            for (cnt in publiCcontours) {
                var pos = Imgproc.boundingRect(cnt)
                var myRect = Rect(pos.x, pos.y, pos.width, pos.height)
                resultList.add(mutableMapOf("x" to pos.x, "y" to pos.y, "width" to pos.width, "height" to pos.height))
            }
            result.success(resultList)
        }
    }
}

