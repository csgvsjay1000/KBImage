//
//  KBImageUtils_03.m
//  KBImage
//
//  Created by feng on 16/8/27.
//  Copyright © 2016年 Gan Tian. All rights reserved.
//

#import "KBImageUtils_03.h"
#import "KBImageUtils_02.h"

@implementation KBImageUtils_03

+(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight{
    
    size_t pixelsWide = 256,pixelsHigh = 256;
    
    uint8_t *destBitmapData = malloc(pixelsWide*pixelsHigh*4);
    
    int nindex = 0;
    for (int j = 0; j < pixelsHigh; j++)
    {
        for(int i = 0; i < pixelsWide; i++)
        {
            nindex=(j*pixelsWide+i);
            destBitmapData[nindex*4+0] = 0;
            destBitmapData[nindex*4+1] = 0;
            destBitmapData[nindex*4+2] = 255 * random();
            destBitmapData[nindex*4+3] = 255;
        }
    }
    UIImage *img_1 = [KBImageUtils_02 drawImageWithData:destBitmapData width:pixelsWide height:pixelsHigh bitsPerComponent_t:8];
    *ptrHeight = pixelsHigh;
    *ptrWidth = pixelsWide;
    return img_1;
}

@end
