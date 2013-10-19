//
//  MNSecondViewController.m
//  ImageMap
//
//  Created by Moo on 8/8/13.
//  Copyright (c) 2013 micmoo. All rights reserved.
//

#import "MNSecondViewController.h"

@interface MNSecondViewController ()

@end

@implementation MNSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"];
    filePath = @"/Users/Moo/Coding/ImageMap/ImageMap/data.txt";
    NSError *err;
    NSData *myData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingUncached error:&err];
    
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:myData
                     options:0
                     error:&error];
                
        // the originating poster wants to deal with dictionaries;
        // assuming you do too then something like this is the first
        // validation step:
            NSMutableDictionary *results = [object mutableCopy];
        [tv setData:results];
        
      //  NSLog(results);
            /* proceed with results as you like; the assignment to
             an explicit NSDictionary * is artificial step to get
             compile-time checking from here on down (and better autocompletion
             when editing). You could have just made object an NSDictionary *
             in the first place but stylistically you might prefer to keep
             the question of type open until it's confirmed */
        
    }

    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
