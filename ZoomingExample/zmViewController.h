//
//  zmViewController.h
//  ZoomingExample
//
//  Created by Faisal Memon on 23/08/2012.
//  Copyright (c) 2012 Faisal Memon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zmZoomableView.h"

@interface zmViewController : UIViewController <UIScrollViewDelegate>
{
    zmZoomableView *handleToZoomableView;
}

/*
 In the xib, we have set the scroll factors (min 0.1, max 40) 
 and set the delegate to the file's owner, i.e. this view controller
 The xib for the scroll view does not have a subview, because we set
 it to zmZoomableView programmatically.
 */
@property (weak, nonatomic) IBOutlet UIScrollView *handleToScrollView;
@property(nonatomic, readonly) zmZoomableView *handleToZoomableView;

@end
