//
//  JRSegmentedTool.m
//  JRKit
//
//  Created by lujianrong on 16/5/9.
//  Copyright © 2016年 lujianrong. All rights reserved.
//

#import "JRSegmentedTool.h"
#import "UIView+JRFrame.h"

@interface JRSegmentedTool(){
    CGFloat _len;//按钮宽度
    NSUInteger itemsCount;//有几个 items
    UIView *_lineView;//线
    CGFloat lastLineX;//上一次 x 的位置
}
@end

@implementation JRSegmentedTool

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"self.selectedSegmentIndex"];
}

- (instancetype)initWithItems:(NSArray *)items target:(id)target selector:(SEL)selector {
    if (!items)  return nil;
    
    self = [super initWithItems:items];
    if (self) {
        itemsCount = items.count;
        lastLineX = 0;
        self.selectedSegmentIndex = 0;
        self.tintColor = [UIColor clearColor];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = _selectedColor ? _selectedColor : [UIColor orangeColor];
        [self addSubview:_lineView];
        
        NSDictionary *selectedDict = [self dictionayWithColor:_selectedColor];
        [self setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
        
        NSDictionary *normalDict = [self dictionayWithColor:[UIColor grayColor]];
        [self setTitleTextAttributes:normalDict forState:UIControlStateNormal];
        [self addTarget:target action:selector forControlEvents:UIControlEventValueChanged];
        /**
         *  添加观察者
         */
        [self addObserver:self forKeyPath:@"self.selectedSegmentIndex" options:NSKeyValueObservingOptionNew |
        NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {// 这里性能还可以优化
    [self setNeedsDisplay];
}

- (NSMutableDictionary *)dictionayWithColor:(UIColor *)color {
    NSMutableDictionary *mDictionary = @{}.mutableCopy;
    mDictionary[NSForegroundColorAttributeName] = color ? color : [UIColor orangeColor];
    mDictionary[NSFontAttributeName] = [UIFont systemFontOfSize:_font ? _font : 13.];
    return mDictionary;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _len = self.jr_w  / itemsCount;
    CGFloat x = lastLineX;
    CGFloat h = 1;
    CGFloat y = self.jr_h - h;
    CGFloat w = _len;
    _lineView.frame = CGRectMake(x, y, w, h);
}

- (void)drawRect:(CGRect)rect {
    __weak typeof(_lineView) line = _lineView;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        line.jr_x = _len *weakSelf.selectedSegmentIndex;
        lastLineX = line.jr_x;
    }];
}

@end
