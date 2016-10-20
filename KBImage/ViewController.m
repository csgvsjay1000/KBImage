//
//  ViewController.m
//  KBImage
//
//  Created by chengshenggen on 8/24/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "ViewController.h"
#import "GLProgram.h"
//#import "KBImageUtils_01.h"
//#import "KBImageUtils_02.h"
//#import "KBImageUtils_03.h"
//#import "KBImageUtils_04.h"
//#import "KBImageUtils_08.h"
#import "KBImageUtils_11.h"


@interface ViewController ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *gpuImageView;

@property(nonatomic,strong)id<KBImageDelegate> imageRender;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.slider.maximumValue = 10;
    self.slider.minimumValue = 0;
    self.slider.value = 1;
    self.label.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.gpuImageView];

    [self reDrawImage];
}


-(void)reDrawImage{

    
    float width,height;
    self.imageView.image = [self.imageRender reDrawImage:&width ptrHeight:&height value:self.slider.value];
    
    CGFloat selfWidth = self.view.frame.size.width;
    
    self.imageView.frame = CGRectMake((selfWidth-width)/2.0, 20, width, height);
    
    self.gpuImageView.image = [self.imageRender reGPUImageDrawImage:&width ptrHeight:&height value:self.slider.value];
    self.gpuImageView.frame = CGRectMake((selfWidth-width)/2.0, 250, width, height);
    
}
- (IBAction)sliderChange:(id)sender {
    
    self.label.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
    float width,height;
    self.imageView.image = [self.imageRender reDrawImage:&width ptrHeight:&height value:self.slider.value];
    
    CGFloat selfWidth = self.view.frame.size.width;
    
    self.imageView.frame = CGRectMake((selfWidth-width)/2.0, 20, width, height);
    
    
    self.gpuImageView.image = [self.imageRender reGPUImageDrawImage:&width ptrHeight:&height value:self.slider.value];
    self.gpuImageView.frame = CGRectMake((selfWidth-width)/2.0, 250, width, height);
//    self.gpuImageView.center = self.view.center;
    
}

void MyCGBitmapContextReleaseDataCallback(void * __nullable releaseInfo,
                                           void * __nullable data){
    
    NSLog(@"MyCGBitmapContextReleaseDataCallback");
    
}

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

-(UIImageView *)gpuImageView{
    if (_gpuImageView == nil) {
        _gpuImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _gpuImageView;
}

-(id<KBImageDelegate>)imageRender{
    if (_imageRender == nil) {
        _imageRender = [[KBImageUtils_11 alloc] init];
    }
    return _imageRender;
}

@end
