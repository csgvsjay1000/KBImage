//
//  ViewController.m
//  KBImage
//
//  Created by chengshenggen on 8/24/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "ViewController.h"
#import "GLProgram.h"
#import "KBImageUtils_02.h"

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

    
    float width,height;
    self.imageView.image = [KBImageUtils_02 reDrawImage:&width ptrHeight:&height];
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
