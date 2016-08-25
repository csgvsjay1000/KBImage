//
//  KBImageUtils_02.m
//  KBImage
//
//  Created by chengshenggen on 8/25/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBImageUtils_02.h"

@implementation KBImageUtils_02

+(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight{
    
    uint8_t *bitmapData,*bitmapData_02;
    size_t pixelsWide,pixelsWide_02;
    size_t pixelsHigh,pixelsHigh_02;
    
    
    UIImage *image = [UIImage imageNamed:@"01.jpg"];
    UIImage *image_02 = [UIImage imageNamed:@"02.jpg"];

    
    size_t bitsPerComponent_t,bitsPerComponent_t_02;
    
    [[self class] loadbytes:&bitmapData image:image ptrWidth:&pixelsWide ptrHeight:&pixelsHigh bitsPerComponent_t:&bitsPerComponent_t];
    
    [[self class] loadbytes:&bitmapData_02 image:image_02 ptrWidth:&pixelsWide_02 ptrHeight:&pixelsHigh_02 bitsPerComponent_t:&bitsPerComponent_t_02];

    int i,j,nindex = 0;
    float blendingRate = 0.7f;
    
    uint8_t *destBitmapData = malloc(pixelsWide*pixelsHigh*4);
    
    for (j = 0; j < pixelsHigh; j++)
    {
        for(i = 0; i < pixelsWide; i++)
        {
            nindex=(j*pixelsWide+i);
            destBitmapData[nindex*4+0] = blendingRate*(bitmapData[nindex*4+0])+((1-blendingRate)*(bitmapData_02[nindex*4+0]));
            destBitmapData[nindex*4+1] = blendingRate*(bitmapData[nindex*4+1])+((1-blendingRate)*(bitmapData_02[nindex*4+1]));
            destBitmapData[nindex*4+2] = blendingRate*(bitmapData[nindex*4+2])+((1-blendingRate)*(bitmapData_02[nindex*4+2]));
            destBitmapData[nindex*4+3] = blendingRate*(bitmapData[nindex*4+3])+((1-blendingRate)*(bitmapData_02[nindex*4+3]));


        }
    }
    UIImage *img_1 = [[self class]drawImageWithData:destBitmapData width:pixelsWide_02 height:pixelsHigh_02 bitsPerComponent_t:bitsPerComponent_t_02];

    
//    free(destBitmapData);
//    free(bitmapData_02);
//    free(bitmapData);
//    bitmapData_02 = NULL;
//    bitmapData = NULL;
    
    *ptrHeight = pixelsHigh;
    *ptrWidth = pixelsWide;
    return img_1;

}

+(UIImage *)drawImageWithData:(uint8_t *)data width:(size_t)destW height:(size_t)destH bitsPerComponent_t:(size_t)bitsPerComponent_t{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreateWithData(data, destW, destH, bitsPerComponent_t, destW*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, NULL, NULL);

    CGImageRef imgref = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imgref];
    
    CGContextRelease(context);

    return img;
}


+(void)loadbytes:(uint8_t *)bitmapData image:(UIImage *)image ptrWidth:(size_t *)ptrWidth ptrHeight:(size_t *)ptrHeight bitsPerComponent_t:(size_t *)bitsPerComponent_t{
    CGImageRef cgimg = image.CGImage;
    
    CGContextRef bitmapContext = NULL;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    size_t dest_w,dest_h;
    
    dest_w = CGImageGetWidth(cgimg);
    dest_h = CGImageGetHeight(cgimg);
    
    uint8_t *bitdata = NULL;
    
    *bitsPerComponent_t = CGImageGetBitsPerComponent(cgimg);
    bitdata = malloc((dest_w)*(dest_h)*4);
    bitmapContext = CGBitmapContextCreate(bitdata, dest_w, dest_h, *bitsPerComponent_t, dest_w*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, dest_w, dest_h), cgimg);
    
    *ptrWidth = dest_w;
    *ptrHeight = dest_h;
    
    *bitmapData = bitdata;
//    free(bitdata);
    
    CGContextRelease(bitmapContext);
    
}

@end
