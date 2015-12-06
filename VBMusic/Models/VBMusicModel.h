//
//  VBMusicModel.h
//  VBMusic
//
//  Created by Vision on 15/11/20.
//  Copyright © 2015年 VisionBao. All rights reserved.
//

#import "VBObject.h"

@class Data,Url_List,Audition_List;
@interface VBMusicModel : VBObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, assign) NSInteger rows;

@property (nonatomic, strong) NSArray<Data *> *data;

@end
@interface Data : NSObject

@property (nonatomic, assign) NSInteger album_id;

@property (nonatomic, assign) NSInteger song_id;

@property (nonatomic, copy) NSString *singer_name;

@property (nonatomic, copy) NSString *song_name;

@property (nonatomic, strong) NSArray<Audition_List *> *audition_list;

@property (nonatomic, strong) NSArray<Url_List *> *url_list;

@property (nonatomic, copy) NSString *album_name;

@property (nonatomic, assign) NSInteger pick_count;

@property (nonatomic, assign) NSInteger vip;

@property (nonatomic, assign) NSInteger singer_id;

@property (nonatomic, assign) NSInteger artist_flag;

@end

@interface Url_List : NSObject

@property (nonatomic, copy) NSString *format;

@property (nonatomic, copy) NSString *size;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *type_description;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger bitrate;

@property (nonatomic, copy) NSString *url;

@end

@interface Audition_List : NSObject

@property (nonatomic, copy) NSString *format;

@property (nonatomic, copy) NSString *size;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *type_description;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger bitrate;

@property (nonatomic, copy) NSString *url;

@end

