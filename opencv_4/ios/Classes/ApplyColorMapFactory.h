//
//  Created by fgsoruco
//
#ifdef __cplusplus
#undef NO
#import <opencv2/opencv.hpp>
#endif
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplyColorMapFactory : NSObject

+ (void) processWhitPathType: (int) pathType pathString: (NSString *) pathString data: (FlutterStandardTypedData *) data colorMap: (int) colorMap result: (FlutterResult) result;

@end

NS_ASSUME_NONNULL_END
