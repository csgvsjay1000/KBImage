//
//  KBImageUtils_05.m
//  KBImage
//
//  Created by chengshenggen on 8/31/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBImageUtils_08.h"
#import "KBImageUtils_02.h"
#import "GPUImage.h"

@implementation KBImageUtils_08


+(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value{
    uint8_t *bitmapData;
    
    size_t pixelsWide,pixelsWide_02;
    size_t pixelsHigh,pixelsHigh_02;
    
    
    UIImage *image = [UIImage imageNamed:@"03.jpeg"];
    
    
    size_t bitsPerComponent_t,bitsPerComponent_t_02;
    
    [KBImageUtils_02 loadbytes:&bitmapData image:image ptrWidth:&pixelsWide ptrHeight:&pixelsHigh bitsPerComponent_t:&bitsPerComponent_t];
    
    float contrast = value;  //曝光度  -10至10 ,0为正常
    int nindex = 0;  //每个像素点下标(包括RGBA)每个下标又包含四个值
    for (int j = 0; j < pixelsHigh; j++)
    {
        for(int i = 0; i < pixelsWide; i++)
        {
            nindex=(j*pixelsWide+i);
            
            int r = (bitmapData[nindex*4+0]-124)*contrast+124;
            if (r>255) {
                r = 255;
            }else if (r<0){
                r = 0;
            }
            int g = (bitmapData[nindex*4+1]-124)*contrast+124;
            if (g>255) {
                g = 255;
            }else if (g<0){
                g = 0;
            }
            int b = (bitmapData[nindex*4+2]-124)*contrast+124;
            if (b>255) {
                b = 255;
            }else if (b<0){
                b = 0;
            }
            
            bitmapData[nindex*4+0] = r;
            bitmapData[nindex*4+1] = g;
            bitmapData[nindex*4+2] = b;
            bitmapData[nindex*4+3] = 255;
        }
    }
    
    UIImage *img_1 = [KBImageUtils_02 drawImageWithData:bitmapData width:pixelsWide height:pixelsHigh bitsPerComponent_t:bitsPerComponent_t];
    
    *ptrHeight = pixelsHigh;
    *ptrWidth = pixelsWide;
    
    free(bitmapData);
    
    return img_1;
    
}

+(UIImage *)reGPUImageDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value{
    UIImage *inputImage = [UIImage imageNamed:@"03.jpeg"];
    GPUImageSaturationFilter *disFilter = [[GPUImageSaturationFilter alloc] init];
    //设置要渲染的区域
    disFilter.saturation = value;
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
