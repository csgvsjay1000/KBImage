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
#import "KBImageUtils_11.h"


@interface ViewController ()

@property(nonatomic,strong)UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.slider.maximumValue = 1;
    self.slider.minimumValue = 0;
    self.slider.value = 1;
    self.label.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
    [self.view addSubview:self.imageView];
    [self reDrawImage];
}


-(void)reDrawImage{

    
    float width,height;
    self.imageView.image = [KBImageUtils_11 reDrawImage:&width ptrHeight:&height value:self.slider.value];
    self.imageView.frame = CGRectMake(0, 0, width, height);
    self.imageView.center = self.view.center;
}
- (IBAction)sliderChange:(id)sender {
    
    self.label.text = [NSString stringWithFormat:@"%.2f",self.slider.value];
    float width,height;
    self.imageView.image = [KBImageUtils_11 reDrawImage:&width ptrHeight:&height value:self.slider.value];
    self.imageView.frame = CGRectMake(0, 0, width, height);
    self.imageView.center = self.view.center;
    
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
