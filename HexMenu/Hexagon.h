//
//  Hexagon.h
//  HexMenu
//
//  Created by Matt Brenman on 12/25/14.
//  Copyright (c) 2014 mbrenman. All rights reserved.
//

#ifndef HexMenu_Hexagon_h
#define HexMenu_Hexagon_h

#import <UIKit/UIKit.h>

@class Hexagon;

@interface Hexagon : UIView

@property (nonatomic, strong,) UIBezierPath *hexPath;
@property (assign) BOOL clickable;
@property (nonatomic, weak) UIColor* fillColor;
@property (nonatomic, weak) UIColor* strokeColor;

- (BOOL)hexagonPathContains:(CGPoint) point;
- (void)animateWithTouch:(CGPoint)touch;

@end

#endif
