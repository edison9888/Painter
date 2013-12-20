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
        
        self.colorArray = [NSMutableArray array];
        
        int colorCount = 20;
        for (int i = 0; i < colorCount; i++) {
            UIColor *color = [UIColor colorWithHue:i / (float)colorCount saturation:1.0 brightness:1.0 alpha:1.0];
            [_colorArray addObject:color];
        }
        
        colorCount = 8;
        for (int i = 0; i < colorCount; i++) {
            UIColor *color = [UIColor colorWithWhite:i/(float)(colorCount - 1) alpha:1.0];
            [_colorArray addObject:color];
        }
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
    
    _simpleColorGrid = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 320, self.view.bounds.size.height - 70)];
    _simpleColorGrid.backgroundColor = PClearColor;
    [self.view addSubview:_simpleColorGrid];
    
    int colorCount = 28;
    for (int i = 0; i < colorCount && i < _colorArray.count; i++) {
        CALayer *layer = [CALayer layer];
        layer.cornerRadius = 6.0;
        UIColor *color = [_colorArray objectAtIndex:i];
        layer.backgroundColor = color.CGColor;
        
        int column = i % 4;
        int row = i / 4;
        layer.frame = CGRectMake(8 + (column * 78), 8 + row * 48, 70, 40);
        [self setupShadow:layer];
        [self.simpleColorGrid.layer addSublayer:layer];
    }
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorGridTapped:)];
    [self.simpleColorGrid addGestureRecognizer:recognizer];
}

- (void) setupShadow:(CALayer *)layer {
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.8;
    layer.shadowOffset = CGSizeMake(0, 2);
    CGRect rect = layer.frame;
    rect.origin = CGPointZero;
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:layer.cornerRadius].CGPath;
}

- (void) updateSelectedColor {
    self.selectedColorLayer.backgroundColor = self.selectedColor.CGColor;
}


- (void) colorGridTapped:(UITapGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self.simpleColorGrid];
    int row = (int)((point.y - 8) / 48);
    int column = (int)((point.x - 8) / 78);
    int index = row * 4 + column;
	
	if (index < _colorArray.count) {
		self.selectedColor = [_colorArray objectAtIndex:index];
	}
    [self updateSelectedColor];
    if ([_delegate respondsToSelector:@selector(updateSelectedColor:)]) {
        [_delegate updateSelectedColor:self.selectedColor];
    }
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
