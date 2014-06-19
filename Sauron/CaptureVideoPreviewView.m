//
//  CaptureVideoPreviewView.m
//  Sauron
//
//  Created by Mark Stultz on 6/18/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

#import "CaptureVideoPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@implementation CaptureVideoPreviewView

+ (Class)layerClass
{
	return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
	return [(AVCaptureVideoPreviewLayer *)self.layer session];
}

- (void)setSession:(AVCaptureSession *)session
{
	[(AVCaptureVideoPreviewLayer *)self.layer setSession:session];
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
	return (AVCaptureVideoPreviewLayer *)self.layer;
}

@end
