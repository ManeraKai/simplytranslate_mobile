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
        fun processBytes(pathString: String, result: MethodChannel.Result) {
            val filename = pathString.replace("file://", "")
            val src: org.opencv.core.Mat = Imgcodecs.imread(filename)

            var grey = Mat()
            Imgproc.cvtColor(src, grey, Imgproc.COLOR_RGB2GRAY)
            var bg = Mat()
            Imgproc.morphologyEx(
                grey,
                bg,
                Imgproc.MORPH_DILATE,
                Imgproc.getStructuringElement(Imgproc.MORPH_RECT, Size(8.0, 8.0))
            )
            var wewe = Mat()
            Core.divide(grey, bg, wewe, 255.0)
            Imgproc.threshold(wewe, wewe, 0.0, 255.0, Imgproc.THRESH_OTSU)

            val processed = Mat()
            Imgproc.GaussianBlur(wewe, processed, Size(7.0, 7.0), 1.0)
//            Imgproc.cvtColor(processed, processed, Imgproc.COLOR_BGR2GRAY)
            Imgproc.threshold(
                processed,
                processed,
                0.0,
                255.0,
                Imgproc.THRESH_OTSU + Imgproc.THRESH_BINARY_INV
            )
            Imgproc.dilate(
                processed,
                processed,
                Imgproc.getStructuringElement(Imgproc.MORPH_RECT, Size(18.0, 18.0)),
                Point(-1.0, -1.0)
            )
            val contours: MutableList<MatOfPoint> = ArrayList<MatOfPoint>()
            Imgproc.findContours(
                processed,
                contours,
                Mat(),
                Imgproc.RETR_EXTERNAL,
                Imgproc.CHAIN_APPROX_SIMPLE
            )
            publiCcontours = contours
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
                resultList.add(
                    mutableMapOf(
                        "x" to pos.x,
                        "y" to pos.y,
                        "width" to pos.width,
                        "height" to pos.height
                    )
                )
            }
            result.success(resultList)
        }
    }
}


//            Imgproc.rectangle(
//                src,
//                Point(pos.x.toDouble(), pos.y.toDouble()),
//                Point((pos.x + pos.width).toDouble(), (pos.y + pos.height).toDouble()),
//                Scalar(0.0, 255.0, 0.0),
//                2
//            )