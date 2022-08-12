//
//  TKMatrix.h
//  TKUIKitDemo
//
//  Created by PC on 2021/6/3.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#ifndef TKMatrix_h
#define TKMatrix_h


#import "TKPoint.h"

struct TKMatrix {
    NSInteger column;
    NSInteger row;
    CGFloat matrix[4][4];
};

typedef struct TKMatrix TKMatrix;

static TKMatrix TKMatrixMake(NSInteger column, NSInteger row) {
    TKMatrix matrix;
    matrix.column = column;
    matrix.row = row;
    for(NSInteger i = 0; i < column; i++){
        for(NSInteger j = 0; j < row; j++){
            matrix.matrix[i][j] = 0;
        }
    }

    return matrix;
}

static TKMatrix TKMatrixMakeFromArray(NSInteger column, NSInteger row, CGFloat *data) {
    TKMatrix matrix = TKMatrixMake(column, row);
    for (int i = 0; i < column; i ++) {
        CGFloat *t = data + (i * row);
        for (int j = 0; j < row; j++) {
            matrix.matrix[i][j] = *(t + j);
        }
    }
    return matrix;
}

static TKMatrix TKMatrixMutiply(TKMatrix a, TKMatrix b) {
    TKMatrix result = TKMatrixMake(a.column, b.row);
    for(NSInteger i = 0; i < a.column; i ++){
        for(NSInteger j = 0; j < b.row; j ++){
            for(NSInteger k = 0; k < a.row; k++){
                result.matrix[i][j] += a.matrix[i][k] * b.matrix[k][j];
            }
        }
    }
    return result;
}

static TKPoint TKPointMakeRotation(TKPoint point, TKPoint direction, CGFloat angle) {
//    CGFloat temp1[4] = {direction.x, direction.y, direction.z, 1};
//    TKMatrix directionM = TKMatrixMakeFromArray(1, 4, temp1);
    if (angle == 0) {
        return point;
    }

    CGFloat temp2[1][4] = {point.x, point.y, point.z, 1};
//    TKMatrix pointM = TKMatrixMakeFromArray(1, 4, *temp2);

    TKMatrix result = TKMatrixMakeFromArray(1, 4, *temp2);

    if (direction.z * direction.z + direction.y * direction.y != 0) {
        CGFloat cos1 = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat sin1 = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat t1[4][4] = {{1, 0, 0, 0}, {0, cos1, sin1, 0}, {0, -sin1, cos1, 0}, {0, 0, 0, 1}};
        TKMatrix m1 = TKMatrixMakeFromArray(4, 4, *t1);
        result = TKMatrixMutiply(result, m1);
    }

    if (direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0) {
        CGFloat cos2 = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat sin2 = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat t2[4][4] = {{cos2, 0, -sin2, 0}, {0, 1, 0, 0}, {sin2, 0, cos2, 0}, {0, 0, 0, 1}};
        TKMatrix m2 = TKMatrixMakeFromArray(4, 4, *t2);
        result = TKMatrixMutiply(result, m2);
    }

    CGFloat cos3 = cos(angle);
    CGFloat sin3 = sin(angle);
    CGFloat t3[4][4] = {{cos3, sin3, 0, 0}, {-sin3, cos3, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}};
    TKMatrix m3 = TKMatrixMakeFromArray(4, 4, *t3);
    result = TKMatrixMutiply(result, m3);

    if (direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0) {
        CGFloat cos2 = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat sin2 = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat t2_[4][4] = {{cos2, 0, sin2, 0}, {0, 1, 0, 0}, {-sin2, 0, cos2, 0}, {0, 0, 0, 1}};
        TKMatrix m2_ = TKMatrixMakeFromArray(4, 4, *t2_);
        result = TKMatrixMutiply(result, m2_);
    }

    if (direction.z * direction.z + direction.y * direction.y != 0) {
        CGFloat cos1 = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat sin1 = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat t1_[4][4] = {{1, 0, 0, 0}, {0, cos1, -sin1, 0}, {0, sin1, cos1, 0}, {0, 0, 0, 1}};
        TKMatrix m1_ = TKMatrixMakeFromArray(4, 4, *t1_);
        result = TKMatrixMutiply(result, m1_);
    }

    TKPoint resultPoint = TKPointMake(result.matrix[0][0], result.matrix[0][1], result.matrix[0][2]);

    return resultPoint;
}


#endif /* TKMatrix_h */
