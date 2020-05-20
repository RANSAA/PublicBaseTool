//
//  TKDotProgressView.m
//  Evaluate
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKDotProgressView.h"

@implementation TKDotProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    self.hView.hidden = YES;
    [self.dotView setLayerCornerRadiusWith:7.5];
}

@end
