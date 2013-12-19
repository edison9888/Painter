//
//  PColorViewController.m
//  Painter
//
//  Created by Chen Yaoqiang on 13-12-19.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import "PColorViewController.h"

@interface PColorViewController ()

@end

@implementation PColorViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self.navigationItem addBackButton:self withAction:@selector(goBack)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(110, 16, 100, 40);
    layer.cornerRadius = 6.0;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 2);
    layer.shadowOpacity = 0.8;
    layer.backgroundColor = _selectedColor.CGColor;
    
    [self.view.layer addSublayer:layer];
    self.selectedColorLayer = layer;
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
