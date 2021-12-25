//
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

@interface AdaptiveThresholdFactory : NSObject


+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data maxValue: (double)maxValue adaptiveMethod: (int) adaptiveMethod thresholdType: (int) thresholdType blockSize: (int) blockSize constantValue: (int) constantValue result: (FlutterResult) result;


@end

NS_ASSUME_NONNULL_END
