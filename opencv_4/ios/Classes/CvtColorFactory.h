//
//  Created by fgsoruco
//
#ifdef __cplusplus
#undef NO
#import <opencv2/opencv.hpp>
#endif
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface CvtColorFactory : NSObject


+ (void) processWhitPathType: (int) pathType pathString: (NSString *) pathString data: (FlutterStandardTypedData *) data outputType: (int) outputType result: (FlutterResult) result;

@end

NS_ASSUME_NONNULL_END
