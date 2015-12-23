//
//  DockButton.h
//  DragDockItem
//
//  Created by zhang minzhang min on 15/12/22.
//  Copyright © 2015年 zhang min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton

@property (assign,nonatomic) NSInteger sort; /*!< 排序 */

-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

@end
