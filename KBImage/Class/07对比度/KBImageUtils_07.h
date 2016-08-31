//
//  KBImageUtils_05.h
//  KBImage
//
//  Created by chengshenggen on 8/31/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBImageUtils_07 : NSObject

+(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value;

+(UIImage *)reGPUImageDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value;

@end
