//
//  CaptureViewController.m
//  Sauron
//
//  Created by Mark Stultz on 6/18/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CaptureViewController.h"
#import "CaptureVideoPreviewView.h"
#import "CaptureController.h"

@interface CaptureViewController ()

@property (nonatomic, weak) IBOutlet CaptureVideoPreviewView *captureVideoPreviewView;
@property (nonatomic, strong) CaptureController *captureController;

- (void)authorizeCaptureSession;

@end

@implementation CaptureViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self authorizeCaptureSession];
	
	AVCaptureSession *session = [[AVCaptureSession alloc] init];
	self.captureVideoPreviewView.session = session;
	self.captureController = [[CaptureController alloc] initWithCaptureSession:session captureVideoPreviewView:self.captureVideoPreviewView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.captureController startCapture];
}

- (void)authorizeCaptureSession
{
	[AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
		if (granted) {
		}
		else {
		}
	}];
}

@end
