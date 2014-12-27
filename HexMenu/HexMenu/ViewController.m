//
//  ViewController.m
//  HexMenu
//
//  Created by Matt Brenman on 12/25/14.
//  Copyright (c) 2014 mbrenman. All rights reserved.
//

#import "ViewController.h"
#import "Hexagon.h"

@interface ViewController ()
- (void)createHexagons;
//- (void)respondToTapGesture:(UIGestureRecognizer *)recognizer;
@property (nonatomic, strong) NSMutableArray* hexagons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHexagons];
}

- (void)createHexagons {
    _hexagons = [[NSMutableArray alloc] init];
    
    float len = 75;
    
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
        Hexagon *touchedHex = [self.hexagons objectAtIndex:(viewTag - 1)];
        if ([touchedHex hexagonPathContains:touchPoint]) {
            NSLog(@"AND IN PATH");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
