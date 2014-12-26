//
//  Hexagon.m
//  HexMenu
//
//  Created by Matt Brenman on 12/25/14.
//  Copyright (c) 2014 mbrenman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hexagon.h"

@implementation Hexagon

- (void)baseInit {
    _hexPath = nil;
    _clickable = NO;
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

- (void)drawRect:(CGRect)rect {
    
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
    
    NSLog(@"about to draw from layout subview");
    if (_hexPath) {

        // Set the render colors.
        [[UIColor whiteColor] setStroke];
        [[UIColor lightGrayColor] setFill];
    
        // Adjust the drawing options as needed.
        _hexPath.lineWidth = 1;
    
        // Fill the path before stroking it so that the fill
        // color does not obscure the stroked line.
        [_hexPath fill];
        [_hexPath stroke];
        
        NSLog(@"Should've drawn a square");
    } else {
        NSLog(@"Path doesn't seem to exist");
    }
}

@end