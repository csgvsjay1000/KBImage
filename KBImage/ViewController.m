//
//  ViewController.m
//  KBImage
//
//  Created by chengshenggen on 8/24/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "ViewController.h"
#import "GLProgram.h"

@interface ViewController ()

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.imageView];
    [self reDrawImage];
}


-(void)reDrawImage{
    uint8_t *bitmapData;
    size_t pixelsWide;
    size_t pixelsHigh;
    
    
    UIImage *image = [UIImage imageNamed:@"333.jpg"];
    
    CGImageRef cgimg = image.CGImage;
    
    CGContextRef bitmapContext = NULL;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    pixelsWide = CGImageGetWidth(cgimg);
    pixelsHigh = CGImageGetHeight(cgimg);
    
    CGSize pixelSizeToUseForTexture;
    CGFloat powerClosestToWidth = ceil(log2(pixelsWide));
    CGFloat powerClosestToHeight = ceil(log2(pixelsHigh));
    
    pixelSizeToUseForTexture = CGSizeMake(pow(2.0, powerClosestToWidth), pow(2.0, powerClosestToHeight));
    pixelsWide = pixelSizeToUseForTexture.width;
    pixelsHigh = pixelSizeToUseForTexture.height;
    
    size_t bitsPerComponent_t = CGImageGetBitsPerComponent(cgimg);
    bitmapData = malloc(pixelsWide*pixelsHigh*4);
    bitmapContext = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, bitsPerComponent_t, pixelsWide*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, pixelsWide, pixelsHigh), cgimg);
    
    CGContextRelease(bitmapContext);
    
    int i,j,nindex = 0;
    
//    for (j = 0; j < pixelsHigh; j++)
//    {
//        for(i = 0; i < pixelsWide; i++)
//        {
////            nindex=((pixelsHigh-j-1)*pixelsWide+i);
//            nindex=(j*pixelsWide+i);
//            bitmapData[nindex*4+0] = 255; // red
//            bitmapData[nindex*4+1]=0; // green
//            bitmapData[nindex*4+2]=0;   // blue
//            bitmapData[nindex*4+3]=125; // alpha
//
//        }
//    }
    
    size_t destW = pixelsWide * 2;
    size_t destH = pixelsHigh *3;
    
    uint8_t *destBitmapData = malloc(destW*destH*4);
    
    nindex = 0;
    int srcIndex = 0;
    
    float rowRatio = ((float)pixelsHigh)/((float)destH);
    float colRatio = ((float)pixelsWide)/((float)destW);
    for(int row=0; row<destH; row++) {
        // convert to three dimension data
        int srcRow = round(((float)row)*rowRatio);
        if(srcRow >=pixelsHigh) {
            srcRow = pixelsHigh - 1;
        }
        for(int col=0; col<destW; col++) {
            int srcCol = round(((float)col)*colRatio);
            if(srcCol >= pixelsWide) {
                srcCol = pixelsWide - 1;
            }
            
            nindex=(row*destW+col);
            srcIndex=(srcRow*pixelsWide+srcCol);

            destBitmapData[nindex*4+0] = bitmapData[srcIndex*4+0]; // red
            destBitmapData[nindex*4+1] = bitmapData[srcIndex*4+1]; // green
            destBitmapData[nindex*4+2] = bitmapData[srcIndex*4+2];   // blue
            destBitmapData[nindex*4+3] = bitmapData[srcIndex*4+3]; // alpha
        }
    }
    
    
//    CGContextRef context = CGBitmapContextCreateWithData(destBitmapData, destW, destH, bitsPerComponent_t, destW*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, MyCGBitmapContextReleaseDataCallback, (__bridge void * _Nullable)(self));

    CGContextRef context = CGBitmapContextCreateWithData(bitmapData, pixelsWide, pixelsHigh, bitsPerComponent_t, pixelsWide*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, MyCGBitmapContextReleaseDataCallback, (__bridge void * _Nullable)(self));
    
    free(bitmapData);
    
    CGImageRef imgref = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imgref];
    self.imageView.image = img;
}

void MyCGBitmapContextReleaseDataCallback(void * __nullable releaseInfo,
                                           void * __nullable data){
    
    NSLog(@"MyCGBitmapContextReleaseDataCallback");
    
}

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _imageView;
}

@end
