//
//  MusicChord.h
//  MusicFoundation
//
//  Un acorde es un grupo de notas y tiene un nombre que se deriva
//  de la nota fundamental
//
//  Created by Enrique Zamudio Lopez on 18/07/08.
//  Copyright 2008 Desarrollo de Soluciones Abiertas, S.C.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SFCMusicFoundation/SFCMusicNote.h>
#import <SFCMusicFoundation/SFCMusicScale.h>

@interface SFCMusicChord : NSObject {

    NSMutableArray *notas;
    SFCMusicNote *fund;
    SFCMusicScale *scale;
    NSString *nombre;
}

//Estos metodos devuelve un acorde de triada basados en la nota indicada,
//respetando la escala indicada. La escala puede ser nil y entonces
//cualquier alteracion necesaria se hara con sostenidos o bemoles basandose
//en la nota fundamental.
+ (SFCMusicChord *)majorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
+ (SFCMusicChord *)minorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
+ (SFCMusicChord *)augmentedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
+ (SFCMusicChord *)diminishedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
+ (SFCMusicChord *)powerChordForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s octave:(BOOL)flag;

- initMajorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
- initMinorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
- initAugmentedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
- initDiminishedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s;
- initPowerChordForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s octave:(BOOL)flag;

//Toma la primera nota, la sube una octava y la pasa al final.
- (void)invertUp;

//Toma la ultima nota, la baja una octava y la pasa al principio.
- (void)invertDown;

- (NSArray *)notes;
- (NSString *)name;
- (SFCMusicNote *)fundamental;
- (SFCMusicScale *)scale;

@end
