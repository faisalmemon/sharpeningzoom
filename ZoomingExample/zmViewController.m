//
//  zmViewController.m
//  ZoomingExample
//
//  Created by Faisal Memon on 23/08/2012.
//  Copyright (c) 2012 Faisal Memon. All rights reserved.
//

#import "zmViewController.h"

@interface zmViewController ()

@end

@implementation zmViewController
@synthesize handleToZoomableView;
@synthesize handleToScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    if (nil == handleToZoomableView) {
        handleToZoomableView = [[zmZoomableView alloc ]initWithFrame:CGRectZero];
        [handleToScrollView addSubview:self.handleToZoomableView];

    } else {
        NSLog(@"already got a zoomable view");
    }
}

- (void)viewDidUnload
{
    [self setHandleToScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// called before this controller's view has appeared
-(void)viewWillAppear:(BOOL)animated
{
	[self.handleToScrollView setZoomScale:1.0 animated:NO];
	self.handleToZoomableView.frame = self.handleToScrollView.bounds;
	self.handleToScrollView.contentSize = self.handleToScrollView.bounds.size;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // this is called because in the xib we set the delegate to the file's owner (which is this
    // view controller), and this view controller implements the protocol UIScrollViewDelegate
    // of which this method is mandatory for supporting pinch/zoom
    return self.handleToZoomableView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scroll view zoomed to zoomScale %f", handleToScrollView.zoomScale);
    [handleToZoomableView updateTextLayersForZoom:handleToScrollView.zoomScale];
}
@end
