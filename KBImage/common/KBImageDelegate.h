//
//  KBImageDelegate.h
//  KBImage
//
//  Created by David on 16/10/19.
//  Copyright © 2016年 Gan Tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBImageDelegate <NSObject>

-(UIImage *)reDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value;

-(UIImage *)reGPUImageDrawImage:(float *)ptrWidth ptrHeight:(float *)ptrHeight value:(float)value;

@end
