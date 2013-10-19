//
//  MNDataBank.h
//  ImageMap
//
//  Created by Moo on 8/11/13.
//  Copyright (c) 2013 micmoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNDataPoint.h"

@interface MNDataBank : UITableViewController{
    NSMutableDictionary *samples;
    NSMutableArray *queue;
    UIPopoverController *popover;

}

- (void)setData:(NSMutableDictionary *)data;

- (id)initWithData:(id)data;
@end
