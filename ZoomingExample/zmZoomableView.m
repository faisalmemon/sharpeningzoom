//
//  zmZoomableView.m
//  ZoomingExample
//
//  Created by Faisal Memon on 23/08/2012.
//  Copyright (c) 2012 Faisal Memon. All rights reserved.
//
#import "zmZoomableView.h"

@implementation zmZoomableView

/*
 Utility method to calculate the size of the given string in helvetica
 at the supplied size and alignment(left or right).
 */
- (CGSize)sizeOfString:(NSString *)string
          WithFontSize:(CGFloat)font_size
         WithAlignment:(CTTextAlignment)alignment
{
    CTFontRef font;
    font = CTFontCreateWithName(CFSTR("Helvetica"), font_size, NULL);
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    
    if (string != nil)
        CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), (__bridge CFStringRef)string);
    
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTFontAttributeName, font);
    CFRelease(font);

    CTParagraphStyleSetting settings[] = {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    return suggestedSize;
}

-(CATextLayer*)createTextLayerForString:(NSString*)string
                           WithFontSize:(CGFloat)font_size
                          WithAlignment:(CTTextAlignment)alignment
                                ForZoom:(CGFloat)zoom_level
{
    CATextLayer *layer = [CATextLayer layer];
    CGSize measuredSize = [self sizeOfString:string WithFontSize:font_size  WithAlignment:alignment];
    layer.string = string;
    layer.fontSize = font_size;
    layer.foregroundColor = [[UIColor blackColor] CGColor];
    layer.frame = CGRectMake(0, 0, measuredSize.width, measuredSize.height);
    layer.contentsScale = zoom_level;
    layer.anchorPoint = CGPointMake(0,1);
    switch (alignment) {
        case kCTLeftTextAlignment:
            layer.alignmentMode = kCAAlignmentLeft;
            break;
        case kCTRightTextAlignment:
            layer.alignmentMode = kCAAlignmentRight;
            break;
        default:
            NSLog(@"Unsupported alignment");
            layer.alignmentMode = kCAAlignmentLeft;
            break;
    }
    return layer;
}

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self != nil)
	{
        CATiledLayer *tempTiledLayer = (CATiledLayer*)self.layer;
        tempTiledLayer.levelsOfDetail = 5;
        tempTiledLayer.levelsOfDetailBias = 2;
        self.opaque=YES;
        if (nil == textLayer) {
            textLayer = [self createTextLayerForString:@"Simple text" WithFontSize:20 WithAlignment:kCTLeftTextAlignment ForZoom:1.0];
            // the text layer is placed on top of the left arm of the +
            // (plus) sign drawn geometrically in the drawLayer method
            textLayer.position = CGPointMake(35,205);
            [self.layer addSublayer:textLayer];
        }
	}
	return self;
}

+(Class)layerClass
{
    return [CATiledLayer class];
}

-(void)updateTextLayersForZoom:(CGFloat)zoomLevel
{
    CATextLayer *replacementTextLayer = [self createTextLayerForString:@"Simple text" WithFontSize:20 WithAlignment:kCTLeftTextAlignment ForZoom:zoomLevel];
    replacementTextLayer.position = textLayer.position;
    [self.layer replaceSublayer:textLayer with:replacementTextLayer];
    textLayer = replacementTextLayer;
}

-(void)drawRect:(CGRect)r
{
    // intentionally defined-but-empty; drawLayer does the work of drawing.
}

-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context,self.bounds);
    
    // draw a simple plus sign as taken from Apple documentation code
    // snippet
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,35,255);
    CGContextAddLineToPoint(context,35,205);
    CGContextAddLineToPoint(context,135,205);
    CGContextAddLineToPoint(context,135,105);
    CGContextAddLineToPoint(context,185,105);
    CGContextAddLineToPoint(context,185,205);
    CGContextAddLineToPoint(context,285,205);
    CGContextAddLineToPoint(context,285,255);
    CGContextAddLineToPoint(context,185,255);
    CGContextAddLineToPoint(context,185,355);
    CGContextAddLineToPoint(context,135,355);
    CGContextAddLineToPoint(context,135,255);
    CGContextAddLineToPoint(context,35,255);
    CGContextClosePath(context);
    
    // Stroke the simple shape
    CGContextStrokePath(context);
}


@end
