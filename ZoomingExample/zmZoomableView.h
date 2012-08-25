//
//  zmZoomableView.h
//  ZoomingExample
//
//  Created by Faisal Memon on 23/08/2012.
//  Copyright (c) 2012 Faisal Memon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>


@interface zmZoomableView : UIView {
    CATextLayer* textLayer;
}

-(id)initWithFrame:(CGRect)frame;

/*
 When the parent scroll view is zoomed, the text layers need to be replaced.
 This is because they are in fact just bitmaps of a particular resolution.
 The resolution is their "contentSize".  Adjusting them to match the zoom
 level means that we get enough detail to avoid pixel aliasing.  This gets
 around the lack of sub-pixel anti aliasing (SPAA) support for text layers.
 */
-(void)updateTextLayersForZoom:(CGFloat)zoomLevel;

@end
