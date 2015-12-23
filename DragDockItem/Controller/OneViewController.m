//
//  OneViewController.m
//  DragDockItem
//
//  Created by zhang minzhang min on 15/12/22.
//  Copyright © 2015年 zhang min. All rights reserved.
//

#import "OneViewController.h"
#import "DockView.h"
#import "ButtonItem.h"
#import "MyButton.h"

#define kButtonTag 200
#define kDistance 40
#define kLineCount 3

@interface OneViewController ()

@property (assign,nonatomic) CGSize size;
@property (strong,nonatomic) DockView *dockView;
@property (strong,nonatomic) ButtonItem *buttonItem;

@property (strong,nonatomic) UIView *selectView;
@property (weak,nonatomic) MyButton *selectButton;

@property (assign,nonatomic) CGPoint beginPoint;

@end

@implementation OneViewController


#pragma mark - System Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setUserInteractionEnabled:YES];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupDock];
    
    [self setupButton];
}

#pragma mark - System Delegate

#pragma mark -开始移动的时候
/**
 *  开始移动的时候
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    [self beginOperation:point];
}

#pragma mark -移动中
/**
 *  移动中
 */
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    [self.selectView setCenter:point];
    
    self.beginPoint = point;
    
    [self moveOperation:point];
}

#pragma mark -移动结束
/**
 *  移动结束
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.selectView setHidden:YES];
    self.selectButton = nil;
    self.selectView = nil;
}

#pragma mark - private method

#pragma mark -在移动的时候进行操作

/**
 *  在移动的时候进行操作
 */
-(void)moveOperation:(CGPoint)point
{
    point = [self changePoint:point];
    
    if (self.selectView) {
        for (NSDictionary *dict in self.buttonItem.buttonArray) {
            
            NSInteger buttonFlag = [dict[self.buttonItem.buttonFlagDictKey] integerValue];
            
            if (buttonFlag) {
                MyButton *button = dict[self.buttonItem.buttonDictKey];
                
                CGRect frame = button.frame;
                
                CGFloat minX = frame.origin.x;
                CGFloat minY = frame.origin.y;
                
                CGFloat maxX = CGRectGetMaxX(frame);
                CGFloat maxY = CGRectGetMaxY(frame);
                
                if (minX <= point.x && point.x <= maxX && minY <= point.y && point.y <= maxY) {
                    
                    [self.buttonItem changeButtonFlagWithOneButton:self.selectButton twoButton:button];
                    
                    [self setupButton];
                    
                    [self.dockView setup];
                    
                    [self.selectView setHidden:YES];
                    self.selectButton = nil;
                    self.selectView = nil;
                    
                    return;
                }
            }
        }
    }
}

#pragma mark -当移到可以互换的区域时，需要进行坐标转换
/**
 *  当移到可以互换的区域时，需要进行坐标转换
 *
 *  @param point 当前移动到的位置坐标
 *
 *  @return CGPoint
 */
-(CGPoint)changePoint:(CGPoint)point
{
    CGRect frame = self.dockView.frame;
    
    CGFloat minX = frame.origin.x;
    CGFloat minY = frame.origin.y;
    
    CGFloat maxX = self.size.width;
    CGFloat maxY = CGRectGetMaxY(frame);
    
    if (minX <= point.x && point.x <= maxX && minY <= point.y && point.y <= maxY) {
        point.y = 44 - (self.size.height - point.y);
    }
    
    return point;
}


#pragma mark -当开始点击时的操作
/**
 * 当开始点击时的操作
 */
-(void)beginOperation:(CGPoint)point
{
    NSInteger count = self.view.subviews.count;
    
    for (NSInteger i = 0; i < count; i++) {
        if ([self.view.subviews[i] isKindOfClass:[MyButton class]]) {
            MyButton *button = self.view.subviews[i];
            
            CGRect frame = button.frame;
            
            CGFloat minX = frame.origin.x;
            CGFloat minY = frame.origin.y;
            
            CGFloat maxX = CGRectGetMaxX(frame);
            CGFloat maxY = CGRectGetMaxY(frame);
            
            if (minX <= point.x && point.x <= maxX && minY <= point.y && point.y <= maxY) {
                
                self.selectView = [button snapshotViewAfterScreenUpdates:NO];
                self.selectButton = button;
                
                frame.size.width *= 1.5;
                frame.size.height *= 1.5;
                
                [self.selectView setFrame:frame];
                
                [self.view addSubview:self.selectView];
                
                [self.selectView setCenter:button.center];
            }
        }
    }
}

#pragma mark -设置按钮
/**
 *  设置按钮
 */
-(void)setupButton
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[MyButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *buttonArray = self.buttonItem.buttonArray;
    
    NSInteger line = 0;
    NSInteger num = 0;
    NSInteger sort = 0;
    
    for (NSDictionary *dict in buttonArray) {
        NSInteger buttonFlag = [dict[self.buttonItem.buttonFlagDictKey] integerValue];
        
        if (buttonFlag == 0) {
            CGFloat w = (self.size.width - 200 - (kLineCount + 1)) / kLineCount;
            CGFloat h = 44;
            
            line = sort / kLineCount;
            
            if (num >= kLineCount) {
                num = 0;
            }
            
            CGFloat x = num * w + (num + 1) * kDistance;
            CGFloat y = line * h + (line + 1) * kDistance;
            
            MyButton *button = dict[self.buttonItem.buttonDictKey];
            
            [button setUserInteractionEnabled:NO];
            
            [button setFrame:CGRectMake(x, y, w, h)];
            
            [self.view addSubview:button];
            
            
            num++;
            sort++;
        }
    }
}

#pragma mark -设置dock
/**
 *  设置dock
 */
-(void)setupDock
{
    self.dockView = [DockView sharkDockView];
    
    [self.dockView setUserInteractionEnabled:YES];
    
    CGFloat x = 0;
    CGFloat y = self.size.height - 44;
    CGFloat w = self.size.width;
    CGFloat h = 44;
    
    [self.dockView setFrame:CGRectMake(x, y, w, h)];
    
    [self.view addSubview:self.dockView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
