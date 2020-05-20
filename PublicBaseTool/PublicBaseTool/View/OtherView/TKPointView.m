//
//  TKPointView.m
//  LianCard
//
//  Created by Mac on 2019/3/26.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKPointView.h"

@implementation TKPointView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    self.backgroundColor = [kColorWhite colorWithAlphaComponent:0];
    self.xibChildView.backgroundColor = [kColorWhite colorWithAlphaComponent:0];
    for (UIView *view in self.dotAry) {
        view.backgroundColor = kColorWhite;
        [view setLayerCornerRadiusWith:3];
    }

}

@end
