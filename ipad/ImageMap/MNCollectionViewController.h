//
//  MNCollectionViewController.h
//  ImageMap
//
//  Created by Moo on 8/11/13.
//  Copyright (c) 2013 micmoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNCollectionViewController : UICollectionViewController{
    
}

@property (copy) NSMutableArray *pics;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;


@end
