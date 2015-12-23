//
//  DockView.m
//  DragDockItem
//
//  Created by zhang minzhang min on 15/12/22.
//  Copyright © 2015年 zhang min. All rights reserved.
//

#import "DockView.h"
#import "ButtonItem.h"
#import "MyButton.h"

#define kDockCount 4
#define kDockHeight 44
#define kButtonTag 100

static DockView *SharedInstance;

@interface DockView()

@property (assign,nonatomic) CGSize size;
@property (strong,nonatomic) ButtonItem *buttonItem;

@end

@implementation DockView

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self setUserInteractionEnabled:YES];
        
        [self setup];
        
    }
    
    return self;
}

#pragma mark -按钮转换
/**
 *  按钮设置
 */
-(void)setup
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[MyButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *buttonArray = self.buttonItem.buttonArray;
    
    NSInteger i = 0;
    
    for (NSDictionary *dict in buttonArray) {
        NSInteger buttonFlag = [dict[self.buttonItem.buttonFlagDictKey] integerValue];
        
        if (buttonFlag) {
            CGFloat w = self.size.width / kDockCount;
            CGFloat h = kDockHeight;
            CGFloat x = i * w;
            CGFloat y = 0;
            
            MyButton *button = dict[self.buttonItem.buttonDictKey];
            
            [button setFrame:CGRectMake(x, y, w, h)];
            
            [self addSubview:button];
            
            i++;
        }
    }
}

#pragma mark - 单例模式

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [super allocWithZone:zone];
    });
    
    return SharedInstance;
}

+(DockView *)sharkDockView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [[DockView alloc]init];
    });
    
    return SharedInstance;
}

#pragma mark - Get and Set

-(CGSize)size
{
    return [UIScreen mainScreen].bounds.size;
}

-(ButtonItem *)buttonItem
{
    return [ButtonItem sharkButtonItem];
}

@end
