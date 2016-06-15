//
//  JRSegmentedTool.h
//  JRKit
//
//  Created by lujianrong on 16/5/9.
//  Copyright © 2016年 lujianrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRSegmentedTool : UISegmentedControl
@property (nonatomic, strong) UIColor   *selectedColor;
@property (nonatomic, strong) UIColor   *normalColor;
@property (nonatomic, assign) CGFloat    font;//字体大小 默认为 13
- (instancetype)initWithItems:(NSArray *)items target:(id)target selector:(SEL)selector ;
@end
