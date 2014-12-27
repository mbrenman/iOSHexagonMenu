//
//  ViewController.m
//  HexMenu
//
//  Created by Matt Brenman on 12/25/14.
//  Copyright (c) 2014 mbrenman. All rights reserved.
//

#import "MenuController.h"
#import "Hexagon.h"

const float len = 75;

@interface MenuController ()
- (void)createHexagons;
//- (void)respondToTapGesture:(UIGestureRecognizer *)recognizer;
@property (nonatomic, strong) NSMutableArray* hexagons;
@property BOOL menuState;

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHexagons];
    _menuState = YES;
}

- (void)createHexagons {
    _hexagons = [[NSMutableArray alloc] init];
    
    float mid_x = CGRectGetMidX([self.view bounds]) - (len / 2);
    float mid_y = CGRectGetMidY([self.view bounds]) - (len / 2);
    
    Hexagon *top_l = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x - (len / 2), mid_y - (3 * len / 4), len, len)];
    [top_l setBackgroundColor:[UIColor clearColor]];
    [top_l setUserInteractionEnabled:YES];
    [top_l setTag:1];
    [self.view addSubview:top_l];
    [self.hexagons addObject:top_l];
    
    Hexagon *top_r = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x + (len / 2), mid_y - (3 * len / 4), len, len)];
    [top_r setBackgroundColor:[UIColor clearColor]];
    [top_r setUserInteractionEnabled:YES];
    [top_r setTag:2];
    [self.view addSubview:top_r];
    [self.hexagons addObject:top_r];
    
    Hexagon *mid_l = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x - len, mid_y, len, len)];
    [mid_l setBackgroundColor:[UIColor clearColor]];
    [mid_l setUserInteractionEnabled:YES];
    [mid_l setTag:3];
    [self.view addSubview:mid_l];
    [self.hexagons addObject:mid_l];
     
    Hexagon *mid_r = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x + len, mid_y, len, len)];
    [mid_r setBackgroundColor:[UIColor clearColor]];
    [mid_r setUserInteractionEnabled:YES];
    [mid_r setTag:4];
    [self.view addSubview:mid_r];
    [self.hexagons addObject:mid_r];
    
    Hexagon *bottom_l = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x - (len / 2), mid_y + (3 * len / 4), len, len)];
    [bottom_l setBackgroundColor:[UIColor clearColor]];
    [bottom_l setUserInteractionEnabled:YES];
    [bottom_l setTag:5];
    [self.view addSubview:bottom_l];
    [self.hexagons addObject:bottom_l];
    
    Hexagon *bottom_r = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x + (len / 2), mid_y + (3 * len / 4), len, len)];
    [bottom_r setBackgroundColor:[UIColor clearColor]];
    [bottom_r setUserInteractionEnabled:YES];
    [bottom_r setTag:6];
    [self.view addSubview:bottom_r];
    [self.hexagons addObject:bottom_r];
    
    Hexagon *center = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x, mid_y, len, len)];
    [center setBackgroundColor:[UIColor clearColor]];
    [center setUserInteractionEnabled:YES];
    [center setTag:7];
    [self.view addSubview:center];
    [self.hexagons addObject:center];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    int viewTag = touch.view.tag;
    
    if (viewTag > 0) {
        NSLog(@"touched %d", viewTag);
        
        //Center button is special
        if (viewTag == 7) {
            [self handleCenterButtonTap];
        } else {
            Hexagon *touchedHex = [self.hexagons objectAtIndex:(viewTag - 1)];
            [touchedHex animateWithTouch:touchPoint];
        }
    }
}

- (void)handleCenterButtonTap {
    float mid_x = CGRectGetMidX([self.view bounds]) - (len / 2);
    float mid_y = CGRectGetMidY([self.view bounds]) - (len / 2);
    
    NSLog(@"CENTER");
    if (_menuState) {
        NSLog(@"Leave menu");
        for (int i = 0; i < self.hexagons.count; i++) {
            if (i != 4 && i != 5) {
                Hexagon *h = [self.hexagons objectAtIndex:i];
                CGPoint o = h.frame.origin;
                o.y -= len;
                
                [h transitionFromMenuTo:o andTo:o];
            }
        }
        
        Hexagon *bottom_l = [self.hexagons objectAtIndex:4];
        Hexagon *bottom_r = [self.hexagons objectAtIndex:5];
        CGPoint bl_o = bottom_l.frame.origin;
        CGPoint br_o = bottom_r.frame.origin;
        
        bl_o.y -= len;
        br_o.y -= len;
        
        [bottom_l transitionFromMenuTo:bl_o andTo:CGPointMake(mid_x - len, mid_y - len)];
        [bottom_r transitionFromMenuTo:br_o andTo:CGPointMake(mid_x + len, mid_y - len)];
    } else {
        NSLog(@"Go back to menu");
        for (int i = 0; i < self.hexagons.count; i++) {
            if (i != 4 && i != 5) {
                Hexagon *h = [self.hexagons objectAtIndex:i];
                CGPoint o = h.frame.origin;
                o.y += len;
                
                [h transitionFromMenuTo:o andTo:o];
            }
        }
        
        Hexagon *bottom_l = [self.hexagons objectAtIndex:4];
        Hexagon *bottom_r = [self.hexagons objectAtIndex:5];
        CGPoint bl_o = bottom_l.frame.origin;
        CGPoint br_o = bottom_r.frame.origin;
        
        bl_o.y += len;
        br_o.y += len;
        
        [bottom_l transitionFromMenuTo:bl_o andTo:CGPointMake(mid_x - (len / 2), mid_y + (3 * len / 4))];
        [bottom_r transitionFromMenuTo:br_o andTo:CGPointMake(mid_x + (len / 2), mid_y + (3 * len / 4))];
    }
    _menuState = !_menuState;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
