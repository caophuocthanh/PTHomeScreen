//
//  ViewController.m
//  Home
//
//  Created by Otatime on 8/19/15.
//  Copyright (c) 2015 Cao Phuoc Thanh. All rights reserved.
//

#import "HomeViewController.h"
#define WIDTH_BORDER_TITLE 2
#define WIDTH_BORDER_BUTTON 0.8
#define ALPHA_BUTTON 0.8

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addWhiteBorder:_titleLabel.layer width:WIDTH_BORDER_TITLE];
    [self addWhiteBorder:_signupButton.layer width:WIDTH_BORDER_BUTTON];
    [self addWhiteBorder:_loginButton.layer width:WIDTH_BORDER_BUTTON];
    [self addWhiteBorder:_facebookButton.layer width:WIDTH_BORDER_BUTTON];
    _signupButton.alpha= _loginButton.alpha=_facebookButton.alpha= ALPHA_BUTTON;
    
    
}
-(void)addWhiteBorder:(CALayer*)layer width:(float)width{
    layer.borderWidth=width;
    layer.borderColor=[[UIColor whiteColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
