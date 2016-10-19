//
//  KBImageUtils_05.m
//  KBImage
//
//  Created by chengshenggen on 8/31/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "KBImageUtils_11.h"
#import "KBImageUtils_02.h"
#import "GPUImage.h"
#import <GLKit/GLKit.h>
#import "KBImageUtils.h"

@implementation KBImageUtils_11


-(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value{
    uint8_t *bitmapData;
    
    size_t pixelsWide,pixelsWide_02;
    size_t pixelsHigh,pixelsHigh_02;
    
    
    UIImage *image = [UIImage imageNamed:@"03.jpeg"];
    
    
    size_t bitsPerComponent_t,bitsPerComponent_t_02;
    
    [KBImageUtils_02 loadbytes:&bitmapData image:image ptrWidth:&pixelsWide ptrHeight:&pixelsHigh bitsPerComponent_t:&bitsPerComponent_t];
    
//    GLKMatrix4 colorMatrix = GLKMatrix4Make(1, 0, 0, 0,
//                                            0, 1, 0, 0,
//                                            0, 0, 1, 0,
//                                            0, 0, 0, 1);  //正常颜色矩阵
    GLKMatrix4 colorMatrix = GLKMatrix4Make(0.3588, 0.7044, 0.1368, 0,
                                            0.2990, 0.5870, 0.1140, 0,
                                            0.2392, 0.4696, 0.0912, 0,
                                            0, 0, 0, 1);  //正常颜色矩阵
    
    
    CGFloat intensity = value;  //强度
    
    
//    float contrast = value;  //曝光度  -10至10 ,0为正常
    int nindex = 0;  //每个像素点下标(包括RGBA)每个下标又包含四个值
    for (int j = 0; j < pixelsHigh; j++)
    {
        for(int i = 0; i < pixelsWide; i++)
        {
            nindex=(j*pixelsWide+i);
            
            GLKVector4 textureColor = GLKVector4Make(bitmapData[nindex*4+0], bitmapData[nindex*4+1], bitmapData[nindex*4+2], bitmapData[nindex*4+3]);
            GLKVector4 outColor = GLKMatrix4MultiplyVector4(colorMatrix, textureColor);
            
            bitmapData[nindex*4+0] =[KBImageUtils rgb:((intensity*outColor.r)+(1-intensity)*textureColor.x)];
            bitmapData[nindex*4+1] = [KBImageUtils rgb:((intensity*outColor.g)+(1-intensity)*textureColor.y)];
            bitmapData[nindex*4+2] = [KBImageUtils rgb:((intensity*outColor.b)+(1-intensity)*textureColor.z)];
            bitmapData[nindex*4+3] = [KBImageUtils rgb:((intensity*outColor.a)+(1-intensity)*textureColor.w)];
        }
    }
    
    UIImage *img_1 = [KBImageUtils_02 drawImageWithData:bitmapData width:pixelsWide height:pixelsHigh bitsPerComponent_t:bitsPerComponent_t];
    
    *ptrHeight = pixelsHigh;
    *ptrWidth = pixelsWide;
    
    free(bitmapData);
    
    return img_1;
    
}

-(UIImage *)reGPUImageDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value{
    UIImage *inputImage = [UIImage imageNamed:@"03.jpeg"];
    GPUImageSepiaFilter *disFilter = [[GPUImageSepiaFilter alloc] init];
    //设置要渲染的区域
//    disFilter.saturation = value;
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
