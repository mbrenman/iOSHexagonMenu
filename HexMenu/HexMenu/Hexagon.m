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
    
    [_hexPath moveToPoint:CGPointMake(origin.x, origin.y)];
    [_hexPath addLineToPoint:CGPointMake(origin.x + size.width, origin.y)];
    [_hexPath addLineToPoint:CGPointMake(origin.x + size.width, origin.y + size.height)];
    [_hexPath addLineToPoint:CGPointMake(origin.x, origin.y + size.height)];
    
    [_hexPath closePath];
    
    UIColor *fillColor = [UIColor redColor];
    [fillColor setFill];
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor setStroke];
    
    NSLog(@"about to draw from layout subview");
    if (_hexPath) {

        // Set the render colors.
        [[UIColor blackColor] setStroke];
        [[UIColor redColor] setFill];
    
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