//
//  PSettingViewController.m
//  Painter
//
//  Created by Chen Yaoqiang on 13-12-11.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import "PSettingViewController.h"

@interface PSettingViewController ()

@property(nonatomic,strong)UIBarButtonItem *rightItem;

@end

@implementation PSettingViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self.navigationItem addBackButton:self withAction:@selector(goBack)];
        [self.navigationItem setNavigationItemTitle:@"工具箱"];
        
        UILabel *shadeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 20)];
        shadeLabel.backgroundColor = PClearColor;
        shadeLabel.textColor = PWhiteColor;
        shadeLabel.font = PFontSize(17);
        shadeLabel.text = @"摇动清屏";
        [self.view addSubview:shadeLabel];
        
        UISwitch *shadeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 20, 51, 31)];
        BOOL shadeOn = [[NSUserDefaults standardUserDefaults] boolForKey:kShadeClean];
        shadeSwitch.on = !shadeOn;
        [shadeSwitch addTarget:self action:@selector(changeShade:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:shadeSwitch];
        
        UILabel *penLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 55, 100, 20)];
        penLabel.backgroundColor = PClearColor;
        penLabel.textColor = PWhiteColor;
        penLabel.font = PFontSize(17);
        penLabel.textAlignment = NSTextAlignmentCenter;
        penLabel.text = @"画笔大小";
        [self.view addSubview:penLabel];
        
        _widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 80, 280, 29)];
        _widthSlider.minimumValue = 1.0;
        _widthSlider.maximumValue = 20.0;
        [self.view addSubview:_widthSlider];
        
        UILabel *redLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 124, 42, 20)];
        redLabel.backgroundColor = PClearColor;
        redLabel.textColor = PWhiteColor;
        redLabel.font = PFontSize(17);
        redLabel.text = @"红色";
        [self.view addSubview:redLabel];
        
        _redSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 120, 230, 29)];
        _redSlider.minimumValue = 0.0;
        _redSlider.maximumValue = 1.0;
        [_redSlider addTarget:self action:@selector(updateColor:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_redSlider];
        
        UILabel *blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 158, 42, 20)];
        blueLabel.backgroundColor = PClearColor;
        blueLabel.textColor = PWhiteColor;
        blueLabel.font = PFontSize(17);
        blueLabel.text = @"蓝色";
        [self.view addSubview:blueLabel];
        
        _blueSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 154, 230, 29)];
        _blueSlider.minimumValue = 0.0;
        _blueSlider.maximumValue = 1.0;
        [_blueSlider addTarget:self action:@selector(updateColor:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_blueSlider];
        
        UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 192, 42, 20)];
        greenLabel.backgroundColor = PClearColor;
        greenLabel.textColor = PWhiteColor;
        greenLabel.font = PFontSize(17);
        greenLabel.text = @"绿色";
        [self.view addSubview:greenLabel];
        
        _greenSlider = [[UISlider alloc] initWithFrame:CGRectMake(70, 188, 230, 29)];
        _greenSlider.minimumValue = 0.0;
        _greenSlider.maximumValue = 1.0;
        [_greenSlider addTarget:self action:@selector(updateColor:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_greenSlider];
        
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(20, 230, 280, 70)];
        _colorView.layer.borderWidth = 1.0;
        _colorView.layer.borderColor = PWhiteColor.CGColor;
        [self.view addSubview:_colorView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToColor)];
        [_colorView addGestureRecognizer:tap];
        
        UIButton *penBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        penBtn.frame = CGRectMake(20, 310, 75, 75);
        [penBtn setImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];
        [penBtn addTarget:self action:@selector(penEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:penBtn];
        
        UIButton *eraseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        eraseBtn.frame = CGRectMake(122.5, 310, 75, 75);
        [eraseBtn setImage:[UIImage imageNamed:@"erase"] forState:UIControlStateNormal];
        [eraseBtn addTarget:self action:@selector(eraseEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:eraseBtn];
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = CGRectMake(225, 310, 75, 75);
        [clearBtn setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:clearBtn];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    BOOL youmi = [[NSUserDefaults standardUserDefaults] boolForKey:kAppRecommend];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setTitle:@"应用推荐" forState:UIControlStateNormal];
    [rightBtn setTitleColor:PWhiteColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = PFontSize(15);
    [rightBtn addTarget:self action:@selector(showAPP) forControlEvents:UIControlEventTouchUpInside];
    
    _rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    if (youmi) {
        self.navigationItem.rightBarButtonItem = _rightItem;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)onlineConfigCallBack:(NSNotification *)notification {
    
    BOOL youmi=[[notification.userInfo objectForKey:kAppRecommend] boolValue];
    [[NSUserDefaults standardUserDefaults] setBool:youmi forKey:kAppRecommend];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (youmi && !_rightItem) {
        self.navigationItem.rightBarButtonItem = _rightItem;
    }
}

- (void)setColor:(UIColor *)color lineWidth:(float)width
{
    const float *colors = CGColorGetComponents(color.CGColor);
    
    // update the sliders with the new value
    _redSlider.value = colors[0]; // set the red slider’s value
    _greenSlider.value = colors[1]; // set the green slider’s value
    _blueSlider.value = colors[2]; // set the blue slider’s value
    
    // update the color of colorView to reflect the sliders
    _colorView.backgroundColor = color;
    
    // update the width slider
    _widthSlider.value = width;
}

-(void)changeShade:(UISwitch *)sender
{
    BOOL shadeOn = [sender isOn];
    [[NSUserDefaults standardUserDefaults] setBool:!shadeOn forKey:kShadeClean];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)updateColor:sender
{
    // get the color from the sliders
    UIColor *color = [UIColor colorWithRed:_redSlider.value
                                     green:_greenSlider.value blue:_blueSlider.value alpha:1.0];
    
    // update colorView to reflect the new slider values
    [_colorView setBackgroundColor:color];
} // end method updateColor:

-(void)updateSelectedColor:(UIColor *)color
{
    [_colorView setBackgroundColor:color];
    
    const float *colors = CGColorGetComponents(color.CGColor);
    
    // update the sliders with the new value
    _redSlider.value = colors[0]; // set the red slider’s value
    _greenSlider.value = colors[1]; // set the green slider’s value
    _blueSlider.value = colors[2]; // set the blue slider’s value
}

-(void)penEvent
{
    [UIView beginAnimations:nil context:nil]; // begin animation block
	[UIView setAnimationDuration:0.5]; // set the animation length
	
	// set all sliders to their max value so the color is white
	[_redSlider setValue:0.0]; // set the red slider’s value to 1
	[_greenSlider setValue:0.0]; // set the green slider’s value to 1
	[_blueSlider setValue:0.0]; // set the blue slider’s value to 1
	
	// update colorView to reflect the new slider values
	[_colorView setBackgroundColor:[UIColor blackColor]];
	[UIView commitAnimations];
}

-(void)eraseEvent
{
    [UIView beginAnimations:nil context:nil]; // begin animation block
    [UIView setAnimationDuration:0.5]; // set the animation length
    
    // set all sliders to their max value so the color is white
    [_redSlider setValue:1.0]; // set the red slider’s value to 1
    [_greenSlider setValue:1.0]; // set the green slider’s value to 1
    [_blueSlider setValue:1.0]; // set the blue slider’s value to 1
    
    // update colorView to reflect the new slider values
    [_colorView setBackgroundColor:[UIColor whiteColor]];
    [UIView commitAnimations]; // end animation block
}

-(void)clearEvent
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                          @"是否清除图画" message:nil delegate:self
                                          cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show]; // show the alert
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex
{
    // if the user touched the Clear button
    if (buttonIndex == 1)
    {
        [self.delegate resetView];
    }
}

-(void)goBack
{
    [self.delegate setColor:_colorView.backgroundColor];
    [self.delegate setLineWidth:_widthSlider.value];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showAPP
{
    [YouMiWall showOffers:NO didShowBlock:^{
        NSLog(@"有米推荐墙已显示");
    } didDismissBlock:^{
        NSLog(@"有米推荐墙已退出");
    }];
}

-(void)pushToColor
{
    PColorViewController *colorVC = [[PColorViewController alloc] init];
    colorVC.delegate = self;
    colorVC.selectedColor = _colorView.backgroundColor;
    [self.navigationController pushViewController:colorVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
