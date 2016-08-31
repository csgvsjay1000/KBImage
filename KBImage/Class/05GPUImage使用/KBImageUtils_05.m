//
//  KBImageUtils_05.m
//  KBImage
//
//  Created by chengshenggen on 8/31/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBImageUtils_05.h"
#import "KBImageUtils_02.h"
#import "GPUImage.h"

@implementation KBImageUtils_05

+(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight{
    uint8_t *bitmapData,*bitmapData_02;
    
    size_t pixelsWide,pixelsWide_02;
    size_t pixelsHigh,pixelsHigh_02;
    
    
    UIImage *image = [UIImage imageNamed:@"01.jpg"];
    
    
    size_t bitsPerComponent_t,bitsPerComponent_t_02;
    
    [KBImageUtils_02 loadbytes:&bitmapData image:image ptrWidth:&pixelsWide ptrHeight:&pixelsHigh bitsPerComponent_t:&bitsPerComponent_t];
    
    float brints = 0.5;  //亮度  -1至1
    int value = brints * 255;
    int nindex = 0;  //每个像素点下标(包括RGBA)每个下标又包含四个值
    for (int j = 0; j < pixelsHigh; j++)
    {
        for(int i = 0; i < pixelsWide; i++)
        {
            nindex=(j*pixelsWide+i);
            bitmapData[nindex*4+0] = bitmapData[nindex*4+0]+value>255?255:bitmapData[nindex*4+0]+value;
            bitmapData[nindex*4+1] = bitmapData[nindex*4+1]+value>255?255:bitmapData[nindex*4+1]+value;
            bitmapData[nindex*4+2] = bitmapData[nindex*4+2]+value>255?255:bitmapData[nindex*4+2]+value;
            bitmapData[nindex*4+3] = 255;
        }
    }
    
    UIImage *img_1 = [KBImageUtils_02 drawImageWithData:bitmapData width:pixelsWide height:pixelsHigh bitsPerComponent_t:bitsPerComponent_t];
    
    *ptrHeight = pixelsHigh;
    *ptrWidth = pixelsWide;
    return img_1;
    
}

+(UIImage *)reGPUImageDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight{
    UIImage *inputImage = [UIImage imageNamed:@"01.jpg"];
    GPUImageBrightnessFilter *disFilter = [[GPUImageBrightnessFilter alloc] init];
    //设置要渲染的区域
    disFilter.brightness = 0.5;
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    *ptrWidth = inputImage.size.width;
    *ptrHeight = inputImage.size.height;
    
    return newImage;
}


@end
