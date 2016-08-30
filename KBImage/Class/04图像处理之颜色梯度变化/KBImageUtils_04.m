//
//  KBImageUtils_04.m
//  KBImage
//
//  Created by feng on 16/8/27.
//  Copyright © 2016年 Gan Tian. All rights reserved.
//

#import "KBImageUtils_04.h"
#import "KBImageUtils_02.h"

@implementation KBImageUtils_04

+(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight{
    size_t pixelsWide = 256,pixelsHigh = 256;
    
    uint8_t *destBitmapData = malloc(pixelsWide*pixelsHigh*4);
    
    
    int startColor[] = {246,53,138};
    int endColor[] = {0,255,255};
    
    float rr = startColor[0] - endColor[0];
    float gg = startColor[1] - endColor[1];
    float bb = startColor[2] - endColor[2];
    
    int nindex = 0;
    for (int j = 0; j < pixelsHigh; j++)
    {
        for(int i = 0; i < pixelsWide; i++)
        {
            nindex=(j*pixelsWide+i);
            destBitmapData[nindex*4+0] = endColor[0] + (int)(rr * ((float)j/pixelsHigh) + 0.5f);
            destBitmapData[nindex*4+1] =  endColor[1] + (int)(gg * ((float)j/pixelsHigh) + 0.5f);
            destBitmapData[nindex*4+2] =  endColor[2] + (int)(bb * ((float)j/pixelsHigh) + 0.5f);
            destBitmapData[nindex*4+3] = 255;
        }
    }
    UIImage *img_1 = [KBImageUtils_02 drawImageWithData:destBitmapData width:pixelsWide height:pixelsHigh bitsPerComponent_t:8];
    *ptrHeight = pixelsHigh;
    *ptrWidth = pixelsWide;
    return img_1;
}


@end
