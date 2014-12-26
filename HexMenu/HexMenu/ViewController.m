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
@property (nonatomic, weak) NSMutableArray* hexagons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHexagons];
}

- (void)createHexagons {
    float len = 75;
    
    float mid_x = CGRectGetMidX([self.view bounds]) - (len / 2);
    float mid_y = CGRectGetMidY([self.view bounds]) - (len / 2);
    
    Hexagon *center = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x, mid_y, len, len)];
    [center setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:center];
    [self.hexagons addObject:center];
    
    Hexagon *top_l = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x - (len / 2), mid_y - (3 * len / 4), len, len)];
    [top_l setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:top_l];
    [self.hexagons addObject:top_l];
    
    Hexagon *top_r = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x + (len / 2), mid_y - (3 * len / 4), len, len)];
    [top_r setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:top_r];
    [self.hexagons addObject:top_r];
    
    Hexagon *mid_l = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x - len, mid_y, len, len)];
    [mid_l setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:mid_l];
    [self.hexagons addObject:mid_l];
     
    Hexagon *mid_r = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x + len, mid_y, len, len)];
    [mid_r setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:mid_r];
    [self.hexagons addObject:mid_r];
    
    Hexagon *bottom_l = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x - (len / 2), mid_y + (3 * len / 4), len, len)];
    [bottom_l setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bottom_l];
    [self.hexagons addObject:bottom_l];
    
    Hexagon *bottom_r = [[Hexagon alloc] initWithFrame:CGRectMake(mid_x + (len / 2), mid_y + (3 * len / 4), len, len)];
    [bottom_r setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bottom_r];
    [self.hexagons addObject:bottom_r];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
