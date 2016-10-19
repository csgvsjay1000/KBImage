//
//  KBImageUtils.m
//  KBImage
//
//  Created by David on 16/10/19.
//  Copyright © 2016年 Gan Tian. All rights reserved.
//

#import "KBImageUtils.h"

@implementation KBImageUtils

//
+(int)rgb:(float) value{
    int r = value;
    if (r>255) {
        r = 255;
    }else if (r<0){
        r = 0;
    }
    return r;
}

@end
