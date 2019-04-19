//
//  rootModel.h
//  QPH
//
//  Created by  on 16/6/22.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface rootModel : NSObject

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

-(id)valueForUndefinedKey:(NSString *)key;

-(void)setNilValueForKey:(NSString *)key;

@property(nonatomic,copy) NSString *rootId;//id

@property(nonatomic,copy) NSString *rootTitle;//标题

@property(nonatomic,copy) NSString *rootImageUrl;//icon

@property(nonatomic,copy) NSString *rootRemark;//备注


@end
