//
//  CaptureController.m
//  Sauron
//
//  Created by Mark Stultz on 6/18/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CaptureController.h"
#import "CaptureVideoPreviewView.h"

@interface CaptureController ()

@property (nonatomic, strong) dispatch_queue_t sessionQueue;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) CaptureVideoPreviewView *captureVideoPreviewView;
@property (nonatomic, strong) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position;

@end

@implementation CaptureController

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
	NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
	AVCaptureDevice *captureDevice = devices.firstObject;

	for (AVCaptureDevice *device in devices)
	{
		if ([device position] == position)
		{
			captureDevice = device;
			break;
		}
	}

	return captureDevice;
}

- (id)initWithCaptureSession:(AVCaptureSession *)captureSession captureVideoPreviewView:(CaptureVideoPreviewView *)captureVideoPreviewView
{
	self = [super init];
	if (self) {
		self.sessionQueue = dispatch_queue_create("com.mark-stultz.sauron.sessionQueue", DISPATCH_QUEUE_SERIAL);
		self.captureSession = captureSession;
		self.captureVideoPreviewView = captureVideoPreviewView;
		
		[self configure];
	}
	
	return self;
}

- (void)startCapture
{
	dispatch_async(self.sessionQueue, ^{
		[self.captureSession startRunning];
	});
}

- (void)configure
{
	dispatch_async(self.sessionQueue, ^{
		NSError *error = nil;
		AVCaptureDevice *videoDevice = [CaptureController deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
		AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		
		if (error) {
			NSLog(@"Error: %@", error.localizedDescription);
		}
		
		[self.captureSession beginConfiguration];
		
		if ([self.captureSession canAddInput:videoDeviceInput]) {
			[self.captureSession addInput:videoDeviceInput];
			self.videoDeviceInput = videoDeviceInput;
			self.videoDevice = videoDeviceInput.device;
			
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.captureVideoPreviewView.previewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
			});
		}

		[self.captureSession commitConfiguration];
	});
}

@end
