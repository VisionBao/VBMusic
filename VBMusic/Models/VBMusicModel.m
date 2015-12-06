//
//  VBMusicModel.m
//  VBMusic
//
//  Created by Vision on 15/11/20.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBMusicModel.h"

@implementation VBMusicModel



+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [Data class]};
}
@end



@implementation Data

+ (NSDictionary *)objectClassInArray{
    return @{@"url_list" : [Url_List class], @"audition_list" : [Audition_List class]};
}

@end


@implementation Url_List

@end


@implementation Audition_List

@end


