//
//  IMMarco.h
//  iMeal
//
//  Created by 萨萨萨 on 15/2/28.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

#ifndef iMeal_IMMarco_h
#define iMeal_IMMarco_h

/**
 *  Debug模式下面输出
 */
#if DEBUG
#define DebugLog(format, args...) \
NSLog(@"[%s, %d]: " format "\n",  strrchr(__FILE__, '/') + 1, __LINE__, ## args);;
#else
#define DebugLog(format, args...) do {} while(0)
#endif

/*!
 @brief 判断三连击，CHECK_ID判断传入类型是否id（会让编译器报错），NOT_NIL判断对象是否为空,SA_EXIST类似MAX，取非空对象，两个都非空则取第一个
 */
#define CHECK_ID(OBJ) \
((void)(NO && ((void)(^(id _){}(OBJ)), NO)), OBJ)

#define NOT_NIL(OBJ) \
(CHECK_ID(OBJ) && ![[NSNull null] isEqual:CHECK_ID(OBJ)])

#define SA_EXIST(_OBJ1, _OBJ2) \
(NOT_NIL(_OBJ1) ? _OBJ1 : _OBJ2)

#endif

