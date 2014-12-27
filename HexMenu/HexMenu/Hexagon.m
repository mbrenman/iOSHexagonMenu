//
//  Hexagon.m
//  HexMenu
//
//  Created by Matt Brenman on 12/25/14.
//  Copyright (c) 2014 mbrenman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hexagon.h"

@interface Hexagon ()
- (void)respondToTapGesture:(UIGestureRecognizer *)recognizer;
- (void)createHexagonIn:(CGRect)rect;
- (float)randZeroOne;
@end

@implementation Hexagon

- (void)baseInit {
    srand(time(NULL));
    
    _hexPath = nil;
    _clickable = NO;
    
    _fillColor = [UIColor whiteColor];
    _strokeColor = [UIColor lightGrayColor];
    
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(respondToTapGesture:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self addGestureRecognizer:tapRecognizer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)createHexagonIn:(CGRect)rect {
    _hexPath = [UIBezierPath bezierPath];
    
    CGPoint origin = rect.origin;
    CGSize size = rect.size;
    
    float hex_side = MIN(size.width, size.height) * 0.95;
    
    float buf = MIN(size.width, size.height) * 0.05;
    
    //hexagon
    [_hexPath moveToPoint:CGPointMake(origin.x + (hex_side / 2), origin.y + buf)];
    [_hexPath addLineToPoint:CGPointMake(origin.x + hex_side - buf, (buf / 2) + origin.y + (hex_side / 4))];
    [_hexPath addLineToPoint:CGPointMake(origin.x + hex_side - buf, (buf / 2) + origin.y + (3 * hex_side / 4) - buf)];
    [_hexPath addLineToPoint:CGPointMake(origin.x + (hex_side / 2), origin.y + hex_side - buf)];
    [_hexPath addLineToPoint:CGPointMake(origin.x + buf, origin.y + (3 * hex_side / 4) - (buf / 2))];
    [_hexPath addLineToPoint:CGPointMake(origin.x + buf, (buf / 2) + origin.y + (hex_side  / 4))];
    [_hexPath closePath];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self createHexagonIn:rect];
    
    // Set the render colors.
    [_strokeColor setStroke];
    [_fillColor setFill];
    
    // Adjust the drawing options as needed.
    _hexPath.lineWidth = 2;
    
    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    [_hexPath fill];
    [_hexPath stroke];
    
    CGContextAddPath(ctx, _hexPath.CGPath);
    CGContextStrokePath(ctx);
}

- (void)respondToTapGesture:(UITapGestureRecognizer *)recognizer {
    CGPoint touchPoint = [recognizer locationInView:self];

    if ([_hexPath containsPoint:touchPoint]){
        _fillColor = [UIColor colorWithRed:[self randZeroOne] green:[self randZeroOne] blue:[self randZeroOne] alpha:1];
        _strokeColor = [UIColor colorWithRed:[self randZeroOne] green:[self randZeroOne] blue:[self randZeroOne] alpha:1];
        
        //Redraw to update color
        [self setNeedsDisplay];
        
        CGSize s = self.frame.size;
        CGPoint o = self.frame.origin;
        
        [UIView animateWithDuration:1.0f
                         animations:^{
                             //Redraws the hexagon with new color
                             [self.layer displayIfNeeded];
                             
                             //Shrinking effect
                             [self setFrame:CGRectMake(o.x + s.width / 2, o.y + s.height / 2, s.width / 100, s.height / 100)];
                             
                             //Rotation effect
                             self.transform = CGAffineTransformRotate(self.transform, M_PI);
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:1.0f
                                              animations:^{
                                                  [self.layer displayIfNeeded];
                                                  
                                                  //Growing effect
                                                  [self setFrame:CGRectMake(o.x, o.y, s.width, s.height)];
                                                  
                                                  //Rotation effect
                                                  self.transform = CGAffineTransformRotate(self.transform, M_PI);
                                              }
                                              completion:nil];
        }];
    }
}

- (BOOL)hexagonPathContains:(CGPoint) point {
    return [_hexPath containsPoint:point];
}

- (float)randZeroOne {
    return (float)(arc4random()) / (float)(UINT32_MAX);
}

@end