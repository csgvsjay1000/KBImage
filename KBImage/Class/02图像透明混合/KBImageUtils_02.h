//
//  KBImageUtils_02.h
//  KBImage
//
//  Created by chengshenggen on 8/25/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBImageUtils_02 : NSObject

+(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight;


+(UIImage *)drawImageWithData:(uint8_t *)data width:(size_t)destW height:(size_t)destH bitsPerComponent_t:(size_t)bitsPerComponent_t;

+(void)loadbytes:(uint8_t **)bitmapData image:(UIImage *)image ptrWidth:(size_t *)ptrWidth ptrHeight:(size_t *)ptrHeight bitsPerComponent_t:(size_t *)bitsPerComponent_t;

@end
