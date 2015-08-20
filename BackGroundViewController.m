//
//  BackGroundViewController.m
//  Home
//
//  Created by Otatime on 8/20/15.
//  Copyright (c) 2015 Cao Phuoc Thanh. All rights reserved.
//

#import "BackGroundViewController.h"
#import <AVFoundation/AVFoundation.h>

#define WIDTH_BORDER_TITLE 2
#define WIDTH_BORDER_BUTTON 0.8
#define ALPHA_BUTTON 0.8

@interface BackGroundViewController () 
@property (weak, nonatomic) IBOutlet UIView *cameraview;
@property (weak, nonatomic) IBOutlet UIView *blurview;

@end

@implementation BackGroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customviewCamera];
    [self addBlurViewCamera:_cameraview];
    
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

-(void)addBlurViewCamera:(UIView*)view{
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.view.frame;
    [view addSubview:visualEffectView];
}

#pragma camera view

-(void)customviewCamera{
    //Capture Session
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //Add device
    // AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device = [self frontFacingCameraIfAvailable];
    
    //Input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input)
    {
        NSLog(@"No Input");
        return;
    }
    [session addInput:input];
    
    //Output
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [session addOutput:output];
    output.videoSettings =
    @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    
    //Preview Layer
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    previewLayer.frame = _cameraview.bounds;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_cameraview.layer addSublayer:previewLayer];
    
    //Start capture session
    [session startRunning];
}

-(AVCaptureDevice *)frontFacingCameraIfAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == AVCaptureDevicePositionFront)
        {
            captureDevice = device;
            break;
        }
    }
    if ( ! captureDevice)
    {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return captureDevice;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
