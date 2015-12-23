//
//  DockView.h
//  DragDockItem
//
//  Created by zhang minzhang min on 15/12/22.
//  Copyright © 2015年 zhang min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DockView : UIView

@property (strong,nonatomic) UIButton *selectButton;

-(void)setup;

+(DockView *)sharkDockView;

@end
