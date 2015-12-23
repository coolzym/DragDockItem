//
//  DockButton.m
//  DragDockItem
//
//  Created by zhang minzhang min on 15/12/22.
//  Copyright © 2015年 zhang min. All rights reserved.
//

#import "MyButton.h"

#define kPercent 0.7
#define kDockHeight 44

@implementation MyButton

-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title
{
    self = [super init];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self setContentMode:UIViewContentModeCenter];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    return self;
}

-(void)click:(UIButton *)button
{
    NSLog(@"%@",button.titleLabel.text);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    contentRect.origin.x = 0;
    contentRect.origin.y = 0;
    
    contentRect.size.height = kDockHeight * 0.7;
    
    return contentRect;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    contentRect.size.height = kDockHeight * (1 - kPercent);
    
    contentRect.origin.x = 0;
    contentRect.origin.y = kDockHeight - contentRect.size.height;
    
    return contentRect;
}

@end
